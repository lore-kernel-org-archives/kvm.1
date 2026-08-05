Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2153C8C46;
	Wed,  5 Aug 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929559; cv=none; b=M9q5M/wJ4eNymK2+W2lXVNufxQfnKn2xumOFyPqTMx2RrcRVb+L5cewYocdgiB24IMrmvE/LB3MDiLi3tE6I3fGMSYi24V5njF0sDPPAKQdZJuzi5hMD2LB1BXSs+h75jRVyzvuRvSrK+HrHwze1WrJ62GQ7OIqW3RELRhGqGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929559; c=relaxed/simple;
	bh=qiNUZxMrdm8mU5U+PfWSX4DHjwmMFnSj2pWqEEYMbPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l+FHcfYAJP+5qytAZVbajg/iYIO7HxX5TXSBSnE+JFGXD3c6sOzWlXAHgcFFD//W4lkV+29JPOpSFmmhZroR6HhGYht5/fWr/UnZmzP9A5Q+j7JW72PgThpw1I6F1mlU0qmABLGJoRJpnCx35PzJl2ja+8nlWCIKl4w2T2+m1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D4u5DeMc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEB8PzqI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D4u5DeMc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEB8PzqI"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785929556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/Nf6Gxd/9lfzxOV0ouil77PrRiaEFU9fAACLKEQtOY=;
	b=D4u5DeMcHBr5Jvn13Ts7KxRLuaWEUxiEJ45DAneVZfkLVTBIyo9wvmYiu9TU+Nv/VR6xA7
	v79jHnmt7zVdnZLq7cZrV6iHvh3JJF6y6Lj7SYiS/22jhZe2IqAmq6OQxrDpEexT6MOfHC
	mrLV5alkk0bi5KO0o4TH6teeP0SK1xVl/UO7ou/iYuonEIBUPaD4Ennxco2dUqlU+WAnpB
	+meWBcqsWk4lOKVUoRucAfiyIShLcbwlLuo1qfCpmc1V6X4smcCKnJFvTAMP+zAeFON80x
	LYX52nD/TpYB/qZfU4esytHVfC0Ryuf/20hM7ZvOiSWQ7bfSw4Zerefilm32dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785929556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/Nf6Gxd/9lfzxOV0ouil77PrRiaEFU9fAACLKEQtOY=;
	b=MEB8PzqI5BETYkCdp/BgCLKYzCRG3v74fMGD8qYkXY6irlE/pWNs1VTPronLaaa1Ov7KPA
	pVD+5x5D8AWi/pCA==
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
Subject: Re: [PATCH v3 01/17] riscv: Introduce instruction table generation
In-Reply-To: <20260707-riscv_insn_table-v3-1-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-1-3f8e5f75ba97@gmail.com>
Date: Wed, 05 Aug 2026 13:32:35 +0200
Message-ID: <87v79o950s.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> +        # Replace all . with _
> +        formatted_inst_name=$name
> +        while [ ! ${formatted_inst_name##*.*} ]; do
> +            prefix=${formatted_inst_name%.*}
> +            suffix=${formatted_inst_name##*.}
> +            contains_dot=${formatted_inst_name##*.*}

Isn't contains_dot always empty, because we only get here if
formatted_inst_name has a dot?

> +        # Instruction only appears in one base
> +        only_base=
> +        if [ "${base}" != "${base%32}" ]; then

Does
           if [ "${base}" = "32" ]; then

work?

Nam
