Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC1463B84
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986375; cv=none; b=RLJ+PL0Z9qDV4qNxeHyKJWIl1C3YqhaTQOeklNTKv3SmzgPkiHVyCDxAv6DMVDj01c4EZtiI4dKJntNX7GLLYYMYSm4KZsMvMgjd5ZhQvWyhbhkgolLvFaa2be267mNhrF0ukn9ojs7zwdfBuyLDgR+lL2Jlq0KkCdi2KGlRi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986375; c=relaxed/simple;
	bh=vGRkCp8CN9ItE9Tqxfjd1G6PBe2XxjW5Iv38PjtgXxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V6vV9LdnOfr05W1Lbzm4EgS99pAxkaE4TOWofyztfKH6JQEWMqTZtjlFkPuXT+p579JfEyWYG3+h6OJZs/OzDxPRvKkos0mGj1tHt5AsMM7LLKKBXcLNtUh8xke4tUIPwRo+GK+a33MaTFupwLixjfDMaKsHJonN80soAjX/vVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LI+9cWyu; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LI+9cWyu"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso4988620a12.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786986373; x=1787591173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PEnRvWyc97A37Ln6PXTQIDa+M4xYXCTC9bYQPyMKWBg=;
        b=LI+9cWyuwuXQ34Oa9TPflio0MPI7btc+Vdrqy8u5TxxeIvoMEm+QRa79mN/q8CMJ06
         Zr21JPU+ZY7IV+JQUSWNepFmwUAPpWhNKrhm5PLsK/tUtGJLLD4WQ842xKOfu71rg/Rl
         IPQFfJjDoh9SXd+wiPdexC/VmE2WPNFHwTm4tR26UzQVAKfcVgO0JedmgGz7y/G9paC1
         xR7d6eDlCp+wZAzUZldloBBz/+55zZALpoQWufTVPwVQp4Y4V8aZpOE8Xu8hQHh2YpmX
         nHm7kxG0wCnpyxxzgdNiVTPey7jl2OyzJk9P8/1zEPshkWsN8zFQmyKJ9+sEaA5AOfhk
         UdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986373; x=1787591173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PEnRvWyc97A37Ln6PXTQIDa+M4xYXCTC9bYQPyMKWBg=;
        b=LFfiE3nO5xzd7N2Di6PfWk0/++oZxh+d5hO8gGedewBOWx12dwqdVoPoKsrHa9cWdZ
         vj+xFs5GGHMNl6Hb+5KpTaH/lSJq6hAuttdJoIoTUUMZWi7luivnlsqlMlTrF2wcF1Ce
         lxAjxWgMynicnVjW1FE/luYI/qDK6/UoHfrxv5tU4KTk4XjVlp/VlbCpfDWBSiOga6WJ
         GJIFXAKiyj1qzXJbB0tKh09mCtYCSn1J+ACsy/bGEByrXzRpMBSkouYvU7/3I33FD+Lo
         6PFEJbRtkasFTtq4xhRok8D+hIHkBFuDpdbv8Bv85+3eBj2kxfQmHEXsVd372nY71kGi
         GZAw==
X-Forwarded-Encrypted: i=1; AHgh+RpO171H4D+/w+ZQylwLo+wjJdsHleRJQ+AYH+TV0NQRmxKBog/fBmm84/Wos8X/lmumAA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhaSYwTI8vk9yoB2cC5ebOP94SPUjODq/IrMh7EPVG0fca2rE8
	41i2aE7SzChlx8YUAqw1OJO25V/jZo6Kc6+qFiJI+ptNP9v1QTbSEp+D1IRcnHPD+DXddrnMwU9
	sbgW0uw==
X-Received: from pgcc4.prod.google.com ([2002:a63:1c04:0:b0:cbe:9e80:c394])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d52c:b0:3c3:a140:9380
 with SMTP id adf61e73a8af0-3cc71c09a97mr31063858637.16.1786986372909; Mon, 17
 Aug 2026 10:06:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:06:12 -0700
In-Reply-To: <87lda5kmye.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814162221.2144473-1-vkuznets@redhat.com> <20260814162221.2144473-5-vkuznets@redhat.com>
 <20260814163105.BDEC31F000E9@smtp.kernel.org> <87lda5kmye.fsf@redhat.com>
Message-ID: <aoM_hK4Vn-xr7NvO@google.com>
Subject: Re: [PATCH 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: sashiko-reviews@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Vitaly Kuznetsov wrote:
> sashiko-bot@kernel.org writes:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The hardcoded `VMPTRLD_INSN_SIZE` of 5 bytes is brittle
> > because `vmptrld` is executed using an inline assembly memory operand
> > constraint (`"m"`), which results in a variable-sized instruction
> > depending on compiler optimizations and register allocation.
> 
> True that, but afair we don't currently have an instruction decoder in
> selftests. I see three ways to move forward:
> 
> - Calculate the size of the instruction with two labels, something like
>   (untested):
> 
>     static inline int __vmptrld(u64 vmcs_pa, int *insn_size)
>     {
>             u8 ret;
> 
>             __asm__ __volatile__ ("movl $(2f-1f), %[size];"
>                                   "1: vmptrld %[pa]; 2:"
>                                   "setna %[ret]"
>                     : [ret]"=rm"(ret), [size]"=m"(*insn_size)
>                     : [pa]"m"(vmcs_pa)
>                     : "cc", "memory");
> 
>             return ret;
>     }
> 
>   and use insn_size in the tests.
> 
> - Stuf __vmptrld() with NOPs after vmptrld and keep the constant jump,
>   just make it loner (e.g. 10 bytes should realistically be enough).
> 
> - Make peace with the fragility (it's just a selftest after all) and
>   leave a comment in vmptrld() that changing the asm there make break
>   the assumption.

Option D: use KVM_ASM_SAFE() to do the heavy lifting.  Completely untested, but
something like so:

static inline int vmptrst_safe(u64 *value)
{
	u64 error_code;
	u8 vector;
	int ret;

	asm volatile(KVM_ASM_SAFE("vmptrst %[value]")
		     "\n\tsetna %[ret]"
		     : KVM_ASM_SAFE_OUTPUTS(vector, error_code),
		       [value]"=m"(*value), [ret]"=rm"(ret)
		     :
		     : "cc", "memory");

	return vector ? vector : ret ? -EINVAL : 0;
}

> Any preferences? Personally, I'm feeling adventurous and can go with the
> first one - calculating the exact size with labels.
