Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126423DA5B1
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589736; cv=none; b=Y8yhq910tLCLtguODLNJS/S5xfhmNPZUbp6sHQcx43sDZm/ODe6MpwD9RuKM6I64htmhWHd3PDCqiAcKnHv3FFo/VrF8YG21OX7RXFqA9JNSrdFmyOHomKgJ0o+tGlJb3I+l1dbWezmlTHys3SfyrKKb5Zt0Tku/dXuUhlgsFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589736; c=relaxed/simple;
	bh=70HVzoXgBf9xx4KP/aPDIabbIQagBnvWfiUYl/XUnfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af6iEKT0gxnyWhTHyh/BKdmneHKY49EWKpdXP88IPHICC7ImsMQX0uPhUG5NyJ0w2WoJuD3ndgL2k5/U8VC+r8Q9n9azuYSVn6oCNqZmjYeaIGJnCNVndo6Atb6pn6vXebXtk+9ugRdqImvlViDNWRbXdgJ8qywXwbN/8+YvjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFluq+23; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFluq+23"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30807ba471bso11688974eec.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781589734; x=1782194534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pI5rWxtEe50KjcsP0jF926SZexIl8kuuOKapFR5YRg=;
        b=BFluq+23cj9Yym5RSM07lnEdhFpFhNcEgV54UGAgICjgSFNUeTGFIhlEhSkzd7hpuO
         u5bTilgsZQ1wdLlYLm5HOD9xytna11XlnYt7DqHvzCFGmMXDbPGJLTwIvvCEcG814W7k
         n7azhY1+iww3TzPMXz0TSTS3TmJbNNkzJJyewmzUH7iJUaxaAQQue6phkcEZXh+UQPHf
         NaQ+JVieyFdoWD58mKWTDGb2VNTl2Y9PZmdHdjZdBV4J5bFQ1naC+oZDdwfZ8DjbsSTn
         kejXlQryo2zK0EWYm2I6JEv/LvT3XKKblJDK0Dxpqa6WTmBZf6dyBQRQix6bJIoXua5p
         vnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589734; x=1782194534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pI5rWxtEe50KjcsP0jF926SZexIl8kuuOKapFR5YRg=;
        b=Fe+e/V2IVkkM9Teg7nvvxn0WjqPLOgZ/7Jk5xUS7wU0Pb1t8zmoStofMnjPIiJJlTq
         vSTblSVpZU2edLwJoXqwiaHDlxXO5UkMDPgrQbQvLyz/xxCLG6OFHOcR35WgnSt5EJbh
         5hau7xAS9aGvhyjBdSPSxbP8oxYkGCCcaJV+4YTrrolXtWmFoIBE0buWoT15nz83wQ6f
         aQlQzIrThTmE7HIr7FCw1xsIP2SKQ35o3LrCf2NAH+44u0pe22Sc+TJmZbaOWk2Ua7cf
         jmKHx6gyIKyPxG6Je3ZLlxVaKAnYDp5QGpNCoAGvUjogMPzx2NtU/xwUwiZn9YgxYHlO
         G11g==
X-Forwarded-Encrypted: i=1; AFNElJ/01gwlix+NalMTtLEi4LgIimCBOV5t42q8zM2nvPG9aTMWxTrIpmmbIgg9w66j0lLGkKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxefWMQ+WCFtx7ibs7N9GP0c3mXts8TE4NOPRmUoT17X+ckMGgN
	//yqqHXOCuLMFkOiwPWGLrvNyrXLCsl3MfKaPeG+UYOS94kBArizmmLU
X-Gm-Gg: Acq92OHD+oXiC3JH/wrJKcvN9Cy7rBOLGGki9Fbq5w7u5BLlsxhsVzXd4f4YtjXW6pM
	qBWBeximibTwSBc6ZvLyz8AQvJ0Uk+1o5HKL4yeHxU+KqVvYo1iAMcQd0qyJWi4a6F/YLCKcBBR
	iVS1Hoqj/tvRSnScivLjAIwc/ukZ+eRqTBWyBKj7l0Qln7rF0Nzj+0SBjAt3UwMZbGgPbS1HEma
	dSxi6V2JCXJ/GFAMboVu1uCB/10FJruB9hhPdrod+vJt1yNaCmWQ6XERse5uSjG9Tq1Ui4g5mG8
	Ufehgd/4wqbG/r27NuzdocGXQwxDxEsQOjEmcVR3EQIQu4Kzxda37pzj9S4GtCahoIL2QexHjM1
	HzSTFFWBx55mtWsRsUJ3yCmcsS9mXebJm1C24/3co9szA8jNigvQ0mNGsJNAbObBEXdngQV+P4x
	24oPg+f1vh8RM=
X-Received: by 2002:a05:7300:e882:b0:304:e2a5:689e with SMTP id 5a478bee46e88-30ba5989923mr1369233eec.2.1781589734142;
        Mon, 15 Jun 2026 23:02:14 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0357sm16552304eec.11.2026.06.15.23.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:02:13 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:02:11 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Conor Dooley <conor@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 03/16] riscv: kgdb: Use generated instruction headers
Message-ID: <ajDm49ucbj6mVRo9@blinky>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-3-54b4736a1e77@gmail.com>
 <87pl1xehi4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl1xehi4.fsf@yellow.woof>

On Thu, Jun 11, 2026 at 08:08:35AM +0200, Nam Cao wrote:
> Charlie Jenkins via B4 Relay
> <devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
> > +#define riscv_insn_branch(_insn, regs_ptr, _opcode, _pc, _comparison, type)     \
> > +	({                                                                      \
> > +		unsigned long _ret;                                             \
> > +		if ((type)riscv_insn_reg_get_val(                               \
> > +			    regs_ptr,                                           \
> > +			    riscv_insn_##_insn##_extract_xs1(_opcode))          \
> > +			    _comparison(type) riscv_insn_reg_get_val(           \
> > +				    regs_ptr,                                   \
> > +				    riscv_insn_##_insn##_extract_xs2(_opcode))) \
> > +			_ret = riscv_insn_##_insn##_extract_imm(_opcode);       \
> 
> Should be
> 		_ret = _pc + riscv_insn_##_insn##_extract_imm(_opcode);

Hmm I am surprised my test cases didn't catch that. Thank you!

- Charlie

> 
> > +		else                                                            \
> > +			_ret = _pc + 4;                                         \
> > +		_ret;                                                           \
> > +	})
> > +
