Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CA305693
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411138; cv=none; b=ZHpFtF+DPWHbaTGeDWi1C/NS0KuKD6644SCD4GgE71rM2HNi8dOZ+iIT12bP1Y0OUPPYOKpN1IX2+G02B7UzqF2zGBunDC+7CfhqS8tLDyclYrjDb0vwpMvGW1vbXk8a1IhDn/AK5NkqmvPSbsYwzl+t/qGhdsaAvveVQuAnA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411138; c=relaxed/simple;
	bh=yjS5dSFpPH1rBFGssmlHMMVeXCrnNZvGHXjHEcEI96E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u9prcT+sCWO0xETXvd33jMbASfFoc66qJbQ6MkwtuJmHysYSn0WmxpUJ4LY1Qp2b7Fzj9tzH561s/eHBAPoRZFTXapTRZgIbZqduP0h+SltdLsnQ2zxKwqYM8pIklQhD2MdWUP4tElvsHb0QfzHMVhpf+BxjIbywV6DvlrSlt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmBjccB9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmBjccB9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6a3ece0d8so904055ad.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411137; x=1783015937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjS5dSFpPH1rBFGssmlHMMVeXCrnNZvGHXjHEcEI96E=;
        b=vmBjccB9Uf0R1moGG4Y9i5cLWx0spZYgmPae2EWn/lMKNQM4N66k6HcgFHoTNb3F5n
         Q+wGIPpdOshwLgp+Mh3sXDQ4o181CUAOX0CY5TVlUKe+SxTME1gukcGhaMWxyvFk7Zlj
         1gJIaSlC0muIW4njMXWGmWKd9E+7Gqz4nItSKag2JUd87XMi+o2sfY50Kc2jR6kavrA+
         XUMbbsC2Bav9OYnWBLiVGApfY5FcZrnmMd5sv66MO41E3dmx5AMk5f+Lm2RK3eAgh8iq
         kp597EovKagw8AODId+hsk1r4fWoL7hI+iU1NjTegHey3Twb547wrochEEGr1inh6TJ5
         fn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411137; x=1783015937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjS5dSFpPH1rBFGssmlHMMVeXCrnNZvGHXjHEcEI96E=;
        b=OqIXckr/ytX/iCF3dxcnaCeVZ1Qykg3+iYDQszAPaE/oetTBtj69Su/x8BM1SvMczq
         FzSXpy1GzibQ20bO8jjMZDLNANEhvjyBrTqNBhok4JeeOuSpM8bwM557rPp6MvVotmuF
         B9hiP2GTyIiZ/lbGXBLbW41kvY3QLF59yqbRJ9vJylPsV5gAAvKjabBYxz8Z8AkOrnef
         5LN61zGJnNB3kIIbMJmEHCXPiGLjqPh+ZsE1G1yI1pYTVnvucOtDJW+U7gInMNF1JBMo
         5eYrth0f1MqdL2y9xZAPsi4s62pJngQYDOXuZ5N6oSgHtYdXRdqdsRBw3hX8v4zyydaG
         SJ0Q==
X-Forwarded-Encrypted: i=1; AHgh+RohEobNG79cQKdr1Tg1tTXO7NiAim91XvwjGEpjxO0ghmPgFiOQ7YwOlxJL1/xfgEzVqZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPnTqdJXN6q/i8cF4rnZH10Q8xFSLV7OMj1HzhOJMfz8kD/D1p
	MpHOosHoonXzA6I+AE6j12L/cU6POr54Ag208xD/sXqaY+PxEUx6RtyrJNHM8tPqfP2wKZ1UfqF
	lbqAQnA==
X-Received: from plht13.prod.google.com ([2002:a17:903:2f0d:b0:2bf:17b5:30c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea07:b0:2bf:2369:a131
 with SMTP id d9443c01a7336-2c7fca0df92mr40937135ad.34.1782411136519; Thu, 25
 Jun 2026 11:12:16 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:12:15 -0700
In-Reply-To: <20260527-kvm-locking-docs-v1-2-4fe8b602ff47@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com> <20260527-kvm-locking-docs-v1-2-4fe8b602ff47@google.com>
Message-ID: <aj1vf7HXJXvHi20f@google.com>
Subject: Re: [PATCH RFC 02/12] Documentation: KVM: Consolidate notes about
 cpu_read_lock() and kvm_lock
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, vannapurve@google.com, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> Move the detail about cpu_read_lock() and kvm_lock to where the acquisition
> order is mentioned.

Why?
