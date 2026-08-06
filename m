Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422BD31352B;
	Thu,  6 Aug 2026 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000194; cv=none; b=LFFIPwIKWHwXbW8d2+XDcOwl4XiJ1rRzNt3Y2x8K0L7DP2c8LYm1HbKC/cbWZ3HrjfStu44xLVOBhVZc4sL2ktBf+AaG/PkT5D3FHDHdU1gmSMm1wO7shg8vQZD34tDzpD3Js/NcjFkb2sTunEshsO+SVBaglLSmUQIUMAwEuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000194; c=relaxed/simple;
	bh=SA1dDGK1hMCaPxy1+vkgdXJOHpv3pEn/RgU7VJg7WnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZwV+DtLxvm+f0U+LJb/swY58k6q+RGlycSX4+N/yHvbLyswLrmoBw7ugZ9JKBUcYJE0OR+y1Zzr90B/mQ1TH/auRk5uybneRNKavzQudHV5EzOok0S0dOgm7Z2o/PdhSS0YXNwNmV5iQ3UjdyA30GOJXzQ2TNEYSW61QCAwmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oy/uxERE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwtbJhpx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oy/uxERE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwtbJhpx"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786000190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMT4S1LkWt8Ik0+XZRVYI9d+h5TnrJVOqIGCgTgfYIs=;
	b=oy/uxERExhL2WaAwWd/K4RgtnvN0AEg7Hn6/85XUvPfoyLwYN+HaaO4X4und2xDRys+BBU
	MpBH0BaoZFoyEbNcnHB189Mh8a2kPnIWAq30qF/8Ie9HBs+EGNLZWlzk+vEVMoNR8m+kAa
	6IsNmonvA0YcReWDC+MwoXW6UqZFGq38AbM5YvUEoAgYZDQqIoMkhf8OkVUSq9Kj6Tfxyg
	zBMcceT5pUQcKbaOdb7XxAdm3Fp+3/K99p5MSm0VqvkGW+2O3YevJLnrIwH77x4wYceT9S
	Han6Wz9QBij6Fwpb5P/HGP2E3FqjgBJwlUBlyViDqC5XvJdAMDXEzQYsw2wFaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786000190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMT4S1LkWt8Ik0+XZRVYI9d+h5TnrJVOqIGCgTgfYIs=;
	b=bwtbJhpx1H17PQArbXdA2T8ILJ7epNL6NyKp17SWMYNcd47jKpDMPD0hISSHG0iOqz1J9X
	uuvpwRmzWve4/8AQ==
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
Subject: Re: [PATCH v3 03/17] riscv: kgdb: Use generated instruction headers
In-Reply-To: <20260707-riscv_insn_table-v3-3-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-3-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 09:09:50 +0200
Message-ID: <87o6ffd8sh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> +#define riscv_insn_branch(_insn, regs_ptr, _opcode, _pc, _comparison, type)     \
> +	({                                                                      \
> +		unsigned long _ret;                                             \
> +		if ((type)riscv_insn_reg_get_val(                               \
> +			    regs_ptr,                                           \
> +			    riscv_insn_##_insn##_extract_xs1(_opcode))          \
> +			    _comparison(type) riscv_insn_reg_get_val(           \

That _comparison(type) looks like _comparison is a function and type is
its argument.

Can we change to
    _comparison (type)riscv_insn_reg_get_val(
to make it clearer?

>  		} else if (riscv_insn_is_c_beqz(op_code)) {
> -			rs1_num = decode_register_index_short(op_code,
> -							      RVC_C1_RS1_OPOFF);
> -			if (!rs1_num || regs_ptr[rs1_num] == 0)
> -				*next_addr = RVC_EXTRACT_BTYPE_IMM(op_code) + pc;
> +			rs1_num = riscv_insn_c_beqz_extract_xs1(op_code);
> +			if (regs_ptr[8 + rs1_num] == 0)
> +				*next_addr = riscv_insn_c_beqz_extract_imm(op_code) + pc;

Would it make sense to include the +8 part in riscv_insn_c_beqz_extract_xs1()?

Nam
