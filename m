Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F23016FB;
	Thu,  6 Aug 2026 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999038; cv=none; b=tUEVeVEXd54TopvbCEt8kwQQ9Y/Li9v9CBDpIUg/6EklQdgRm9TsGyWH1FEOM4uZBjA74Md9Fyd29gdXOz+YbGhl3pzJKjL4WpJq5B8+q3pGTzJkr7eHDryx2o4UsvHBZJM0QMY2erdFLOhBGRbr1ftoKEc4CN5IpJvL+pwfvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999038; c=relaxed/simple;
	bh=sNvMyVmUpRAfzcSXPr1g2CIkuQnrdvuZJp9As/3btz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=plRsikPKRj60EY5llhF0cHavkVgcxr7uGEOmJQFYF6o3iZkMaxX79XX6EEboHeZ1GlTITqwh4IaDEyxyq3awWTPjCRAdlPON6Fp5teDH6jeYCtSV3XsTHr6+OvrqDBCIzcUlEscv4YKVLb5EIMYd3Ru5PXk8yngEbs+MCtNEduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeOlfN+u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JtCtLWZW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeOlfN+u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JtCtLWZW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785999034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3YEdpBzGJfCE9OG01zLjkQZVUUGB2Ok8wj7FV80Wpo=;
	b=IeOlfN+uUd41IzpnVVeFTGiSNJzEZiJDadZyDldZWHnQFj0Cjb+64np/UNsudJCXnfbDiU
	3Z1WAvs1jg8VgQQa5eZUNlDk/UrcL/KON9Zss9ZrBCkqEybinXlDr1rSneL8Y+hsrFwrZ/
	Zsk3Fe/WYyX8L/1k/uMPl67wN8yXysW5bIVpHQkfkpEjudbIBtBlJZ/QvnfiPMqTbgidzf
	4T7wHiyTZOK/ZZbdYXdrIUoAv3nfiNcI0+4z9cNwmSygyu869QOuXC8X29m6+82u2iYjj7
	9Kj0ksoNGpm2B2hsbY9lxuzvCbqzud31ryL3OuxD+UpTVCvvw29cGEfMuAPZ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785999034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3YEdpBzGJfCE9OG01zLjkQZVUUGB2Ok8wj7FV80Wpo=;
	b=JtCtLWZWHSsSUdkjhlr/qrdsxP8mDAZVs7eb0+pCe/dXM8MCf6cXP0BCZtYYzfUFx7e1LM
	czhWMq2Lo1n2JVCw==
To: Charlie Jenkins <thecharlesjenkins@gmail.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?=
 <radim.krcmar@oss.qualcomm.com>,
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Charlie Jenkins
 <thecharlesjenkins@gmail.com>
Subject: Re: [PATCH v3 02/17] riscv: alternatives: Use generated instruction
 headers for patching code
In-Reply-To: <20260707-riscv_insn_table-v3-2-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-2-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 08:50:32 +0200
Message-ID: <87qzkbd9on.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> @@ -78,14 +79,24 @@ static void riscv_alternative_fix_auipc_jalr(void *ptr, u32 auipc_insn,
>  					     u32 jalr_insn, int patch_offset)
>  {
>  	u32 call[2] = { auipc_insn, jalr_insn };
> +	u32 auipc_imm;
>  	s32 imm;
>  
>  	/* get and adjust new target address */
> -	imm = riscv_insn_extract_utype_itype_imm(auipc_insn, jalr_insn);
> +	imm = riscv_insn_auipc_extract_imm(auipc_insn) + riscv_insn_jalr_extract_imm(jalr_insn);
>  	imm -= patch_offset;
>  
> +	/*
> +	 * When the 32-bit immediate is split across auipc and jalr, the
> +	 * constructed immediates need to be treated as individually sign
> +	 * extended numbers. Add the sign bit of the lower 12 bits to the upper
> +	 * 20 bits to undo the bleeding of the sign.
> +	 */
> +	auipc_imm = (imm & BIT(11)) << 1;
> +
>  	/* update instructions */
> -	riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
> +	riscv_insn_auipc_insert_imm(&call[0], auipc_imm);
> +	riscv_insn_jalr_insert_imm(&call[1], imm);

Looking at the old riscv_insn_insert_utype_itype_imm(), for auipc we have

	*utype_insn &= ~(RV_U_IMM_31_12_MASK);
	*utype_insn |= (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1);

but the new code does

	auipc_imm = (imm & BIT(11)) << 1;
	*_insn &= ~GENMASK(31, 12);
	*_insn |= (((auipc_imm >> 12) & GENMASK(19, 0)) << 12);

which is not equivalent. The new code is missing (imm & RV_U_IMM_31_12_MASK)
from the old code.

Or am I confused somewhere?

Nam
