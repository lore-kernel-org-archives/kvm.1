Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409443;
	b=uID4e2JbnUOAJL06+fxT02bUQVsjyZr30Hthki9R+AGLcLloLkvTKCvGvahSlgV5o2Nj
	 VPFwLOjtWEvCzV5aKKEOVjLz1WyFhl9qKgv1+UULPQo5Npn720YEYWtaxO5NUU67iSlfp
	 6AUYJDhyMjVKNCsi7GOnLE24a26Y0NXJkWyGf78oyiDjzjdnPobl+iCx+edWfiz/f8tts
	 EfEkL4Emes1h1/PZAQqG9QMdTz7+F75orHP1hWW/CiVuxd3UQMzzpg3yABIaX/hEYlDf6
	 gxvuVmPx3v+QVYnqPzzPqWST14E7886bN+sKlvG20UtQYd9Dtdeqkv+isEDB7ViFceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Xohx1IjDZdPJHBCO9sIOedwalhMTflOLnFId8LnvsXI=;
	b=kjdLgkLwO8omzHtoTmKz1e+evNpX2XbY41/kjokxWE5AgeEyBd/qQOBoKpshpmxM08Bw
	 ViPZ2DBcE++T5OyiK5oi+1Ek68VTFzA0mCn1O7IW29UAHo0Y1SWcjI6pBsAmXGbnlYfSg
	 ehL6CXCJyTeqwTexTOrWB+SczFaAlRM8OjzNxMbU9PKYbTt3pAhr8GaiKTToaWW4x16xw
	 nfNLqOhjE5QDcTmLNzriqjHux0Z74Hc67cbTsxrJUdKuugM5fLk5kjFW98exdMuqV/RDC
	 nVPTzhUeFd5+IXGsnopHkiTAf+v/TkXckldE4TM/SklaT5Vc+aOWeXPAV+lBHYU4YWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="n/7yjK/k";
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300A606A324
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 15:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B300A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n/7yjK/k
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed08904845so47768805ad.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794409442; x=1795014242; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xohx1IjDZdPJHBCO9sIOedwalhMTflOLnFId8LnvsXI=;
        b=n/7yjK/kTZvRrtlAjD9jXSl4O4X++3TVgI0zZran1lmgIqefGlQoYyAB3too7WEhWW
         EOhAilb/PE6ciMYe2naEPqjM3T/dDV3Mo1c1O+WOZlAfrt2uVOSqzTV3SlTLb6pWTdOp
         WKIkgJtuUjbxx/fusxCQoDo6wiTI3f1E7mbxNCy7SRomYbogWuBjKknekLThyZA6kgym
         if8FSqiTSgvLu0Bb7EyE8V/9stC9m9ex7w1gh3RviydfZOLwYQ+LAyFbmc+2CFIKX73K
         XnVHbGokuP8uJ1WaAE1pIl+pOGBeKf+/jbaUXu7QSIbPRPT9kwAApLrIkTBImcdSlPVh
         8QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409442; x=1795014242;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xohx1IjDZdPJHBCO9sIOedwalhMTflOLnFId8LnvsXI=;
        b=j9fXXgBjOgFinqOQrlAeMY/8brEhFoSF6I1VRd/KQBtmdzcwUMMIaSQoV3F5jDAPXc
         7CrHXWi92HcqxzED/gHMJv+kX/sVL7Mr56Qet+xdWtn41vR9TA9e/qCHliC90Bw3t/KT
         HtcSzeD3YMnrTWUKA2WlDbGshUO6nvbRYmrnYstMXH++es2omFkZ532HT5mTjZcnYC+V
         Cp+QAaTD7MKkdmg2cVNxCMYq8msLzkUHeORRAH1c4IQI31qnWDHJq7wbpLW9/xr0eIWe
         IZQ3OzdOOqxCsGnbsTjetapKmOa+m0FOzVRiuEOxRqBUK1aDHT1VWTeKfd0HivZ+T2TN
         m8Jg==
X-Forwarded-Encrypted: i=1; AL+hErHuaGZvP+zQoLmj8zpcPrtmxJsQLkYZjdWsmxEXfVUKrwlSpVsnExq1V1mA/PHp8OX/ubc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HElokInPqxSM7FHZQggeA1DH9ItXn8TM4gxNReepr6tJq5ezY
	fWOFOHaqxqSUm8ClnB6aZUjv+tlagph5vwpA0LV6Sp4PWwiWOPWAenkOyMKQYmXtVJTGK6i6bv1
	LBiDamw==
X-Received: from plgd1.prod.google.com ([2002:a17:902:cec1:b0:2eb:260:cd54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f645:b0:2df:aed3:2ac0
 with SMTP id d9443c01a7336-2edd76d544cmr31113705ad.10.1794409441694; Wed, 11
 Nov 2026 07:04:01 -0800 (PST)
Date: Wed, 11 Nov 2026 07:04:00 -0800
In-Reply-To: <20261111122128.12998-1-sarunkod@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111122128.12998-1-sarunkod@amd.com>
Message-ID: <avSD4O4AELPcmhqb@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2] x86/kvm: Use RCU for svm_vm_data_hash
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, vasant.hegde@amd.com, 
	suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="us-ascii"

KVM: SVM:

"x86/kvm:" is specifically for guest-side code, e.g. arch/x86/kernel/kvm.c

> Changes since v1:

In the future, please wait the "normal" amount of time before sending a new
version, e.g. a day or two for something relatively simple like this.  I.e.
treat feedback from Sashiko like feedback from a human reviewer, and don't spam
patches.

There are times when it's acceptable to break the "don't spam patches" rule, but
this isn't one of those times.

>  int avic_vcpu_precreate(struct kvm *kvm)
> @@ -373,9 +373,12 @@ void avic_vm_pre_destroy(struct kvm *kvm)
>  	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
>  		return;
>  
> -	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
> +	{
> +		guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
> +		hash_del_rcu(&kvm_svm->hnode);

Eww.  Don't open code scoped_guard(), e.g. this should work:

	scoped_guard(spinlock_irqsave, &svm_vm_data_hash_lock)
		hash_del(&kvm_svm->hnode);

	synchronize_rcu();

I'm a little hesitant to put a full synchronize_rcu() in the destroy path, but
in practice it's should be ok.
