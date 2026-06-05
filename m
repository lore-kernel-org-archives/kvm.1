Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7698315793
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684335; cv=none; b=inbN1GtuHc4RVHHKLsboLgctDlbHb/ZP/RsJqlYI4RN+hYDz6IcF6BIxOYN6JkshgsuUav1Ps8ib1FeFrI7Y9MMQRFwk3tJwMXlRuf41gEIjV2TtSmKsHe1liW9bdJamHU7uz2DzM0+sga9T/x0l2YyrlvTeVVBL0pp7PPM8Spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684335; c=relaxed/simple;
	bh=LzMMm43KNjsWJauyDY0i9cbiBIu4ujz9v2ASH+EDrN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WxZhByE/6p+dMVR1ntJlR1nDz1G+s3Qc7rCawp4zGzVYaWac5JHuQGC9AaCHra85VpeqmBECQ+D1mgs/SBFrHKPuCMgsF3W6NIaI8/wxP1nN9a4XPN+pN9hT1b6J0hKG7j+xz8WehCs7ILNhkN73gzVa/OuGE7z2/Bg4oe/m7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPmsdzAg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPmsdzAg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84235f9b91fso1646619b3a.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684334; x=1781289134; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqLqWc+ojpcNasZek2io2Hfn6LBlulfJoVnyGFsr1eo=;
        b=GPmsdzAgrQbw+05pA+i6UgvdIs/9tFRzhaZvH1Cy3qbjyDENUJJCvuzxh1j/89AIVI
         l/2VcPSLd4032aMTucytTEEU+9FAdZ3glOQJG/sd611toZbK0Q/nq7dxwnXYYf+WzkpO
         EqRit92m+egQ1b1MN9dr7j5mY/ArYqc/aMIQ6y9dqjGHdzq0hw+c2tzQxeAbB+lGGZV8
         vM3ZPuhT5pYzUtV5C8MApS++aCAyZ9pRY455L0fege36WmTUl4GPZ1T+H0yaHjKJVU/C
         TAdul1wOH640d0dzrRG2Vl8X8hvsOYhScMSMcHXyO3pTFjk22XyK4jiJEBVy/KxoH/vc
         JKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684334; x=1781289134;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqLqWc+ojpcNasZek2io2Hfn6LBlulfJoVnyGFsr1eo=;
        b=NBir9xOhYJo5DDox9oYtxfl1v+9xrSU62UO4RlM7AaVylQN0crPzeq0W2z6VA2UjjX
         AInt/gou6TMyUK6yySSbN6eCd4x0nUTYnN5jDuw7cRQmu5tuvzxR1mt8qtDt7Zel91uU
         ef0q/InIREIRHToPR8qohTph0/bPv4Gp4HF6o0hgq8y90+s/ecnLvwRGJ/3UAoQ6gN1V
         buUXXbx+pkkOZ1jU4mISBhXAOjYU2lP229HbDmTeYr8/IqP/xhB13fE+adRMIKh0qRSt
         gAhP5+gaktrxJ62K4SUyXhGUWrTeDI2CQQmwqT0jchI65q0EMBPE7s+UHEtonLLU46Ro
         VGcw==
X-Forwarded-Encrypted: i=1; AFNElJ9DZ1k1TlfUgitdMYHNDSj1upbvqmRaUn3CqNKQZaBt78n+JF5/wB9eL28L34wMcXebUvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5m/dE5Fc6kK3mK10EPp+xEab8NoNFnBUs9XUxicmDoyPwXHO
	IzdwQxwndleE0ZjnbTEv3XBGyANN159qd30F9XGeHHbps+fJD2Tt3WNA40QiM3dXohWXIj9+GYC
	rpWIrHw==
X-Received: from pfn35.prod.google.com ([2002:a05:6a00:a223:b0:842:b0e7:887d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d07:b0:842:4bf8:cfdb
 with SMTP id d2e1a72fcca58-842b0f83825mr4893588b3a.32.1780684333711; Fri, 05
 Jun 2026 11:32:13 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:31:43 -0700
In-Reply-To: <20260528031545.1879-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528031545.1879-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <178068428437.2236989.13997430710887045156.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Fix wrong return value type in guest_cpuid_has()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, lirongqing <lirongqing@baidu.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 27 May 2026 23:15:45 -0400, lirongqing wrote:
> The function guest_cpuid_has() is declared with a return type of 'bool'.
> However, when kvm_find_cpuid_entry_index() fails to locate a valid CPUID
> entry, the code incorrectly returns 'NULL' instead of 'false'.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Fix wrong return value type in guest_cpuid_has()
      https://github.com/kvm-x86/linux/commit/f92d4f74de4f

--
https://github.com/kvm-x86/linux/tree/next
