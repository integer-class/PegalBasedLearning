"""Create users, interviewees, expressions tables

Revision ID: a11f46fc81a0
Revises: 
Create Date: 2024-12-07 23:31:33.366464

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy import Enum as ENUM

# revision identifiers, used by Alembic.
revision: str = 'a11f46fc81a0'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    # Create users table
    op.create_table(
        'users',
        sa.Column('id', sa.BigInteger, primary_key=True, autoincrement=True),
        sa.Column('username', sa.String(255), nullable=False),
        sa.Column('email', sa.String(255), nullable=False),
        sa.Column('hashed_password', sa.String(255), nullable=False),
        sa.Column('remember_token', sa.String(100)),
        sa.Column('created_at', sa.TIMESTAMP()),
        sa.Column('updated_at', sa.TIMESTAMP()),
        sa.Column('is_active', sa.Boolean(), nullable=False)
    )

    # Create interviewees table
    op.create_table(
        'interviewees',
        sa.Column('id', sa.BigInteger, primary_key=True, autoincrement=True),
        sa.Column('name', sa.String(255), nullable=False),
        sa.Column('gender', ENUM('male', 'female'), nullable=False),
        sa.Column('email', sa.String(255), nullable=False),
        sa.Column('is_interviewed', sa.Boolean(), nullable=False, default=False),
        sa.Column('created_at', sa.TIMESTAMP()),
        sa.Column('updated_at', sa.TIMESTAMP())
    )

    # Create expressions table
    op.create_table(
        'expressions',
        sa.Column('id', sa.BigInteger, primary_key=True, autoincrement=True),
        sa.Column('interviewee_id', sa.BigInteger, nullable=False),
        sa.Column('interviewer_id', sa.BigInteger, nullable=False),
        sa.Column('sad', sa.Integer(), nullable=False),
        sa.Column('disgust', sa.Integer(), nullable=False),
        sa.Column('surprise', sa.Integer(), nullable=False),
        sa.Column('angry', sa.Integer(), nullable=False),
        sa.Column('fear', sa.Integer(), nullable=False),
        sa.Column('happy', sa.Integer(), nullable=False),
        sa.Column('neutral', sa.Integer(), nullable=False),
        sa.Column('created_at', sa.TIMESTAMP()),
        sa.Column('updated_at', sa.TIMESTAMP())
    )

    # Add foreign keys for expressions table
    op.create_foreign_key(
        'expressions_interviewee_id_foreign', 
        'expressions', 'interviewees', 
        ['interviewee_id'], ['id'], 
        ondelete='CASCADE'
    )
    op.create_foreign_key(
        'expressions_interviewer_id_foreign', 
        'expressions', 'users', 
        ['interviewer_id'], ['id'], 
        ondelete='CASCADE'
    )

def downgrade():
    op.drop_constraint('expressions_interviewer_id_foreign', 'expressions', type_='foreignkey')
    op.drop_constraint('expressions_interviewee_id_foreign', 'expressions', type_='foreignkey')
    op.drop_table('expressions')
    op.drop_table('interviewees')
    op.drop_table('users')
