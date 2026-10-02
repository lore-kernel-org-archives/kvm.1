Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB03B27F5
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975301; cv=none; b=eurFaoiphjf7hjXmmOmn72MI1y7Udx3nTrG9vEr2f8+jVoim7nG/SmpzuKESs3eRul4JhM2pTvca4nxRiRT9WcwzOwcrrjaLevjK31Ubd8ZMemowLHtDGzrxPNfmlJVCJfIow15A/5/z0bhvhq1BR7HZ0Y8NJcGsMPavJubnvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975301; c=relaxed/simple;
	bh=PBAHaD8xQ10qTO5DVYhs5dgCsVz7/DJgL5T+NL3ImSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3c/wjhDakf2JZBSov+cf7Upn6W8dwzP49ByB9m4T+TsuyTAb1A4fZpvmBvNXiR6xTGdZuiSH1KiotlWeLFRJGJ9gdnnNlJPlbIpmrDoFUub3qAwQvp5zGWto1O+O0IRPXm4pWr8bUkUzD4kIRNDIYGX2ZRWm5qZ2BrwPSdrN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTIn/aEq; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTIn/aEq"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e2f3251e91so213335ad.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975299; x=1791580099; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XXwhsFESQJgrRakBtjUjCDlfTD0yj3Lco0tsWkbwp4=;
        b=tTIn/aEq0/jKXkUpZ+AKFIjW0Y7A5DPDlVnf3yj9WOARXArr0CHrtSunKlD4KQTKg/
         YGkRRJDTMGEMeGXL2JvhpQwnyx7Htl4NfVqMsnWgYmgUSjoluNnSDjiuQ1wwv7hz6s/Y
         cef3HJjmGdO4Hj6WQjKnA4SJxYo/tBy1MuLsb9g3PIW6F20/TmNnECLf5F3KFCtJ/tsT
         4qdhtjrcusJdDd/E8i/YNAPK11TtjKjD0lVHfBozsRjopEwyA1KmpByFKpdyS9DM7XhL
         Ji9DF5E0qMjQejwjlF9wBcLwVjf+AjMQCeYfslDbPtm17Axc2r6GpbPbf/umMF0UoGad
         ud7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975299; x=1791580099;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+XXwhsFESQJgrRakBtjUjCDlfTD0yj3Lco0tsWkbwp4=;
        b=HLHPF+QzsiV00+dHXoMzCa4wg0hE15ip+rISAq3iO+lhAnNa+OonKJUMLjWioux5Bb
         GbnUhT5i2qvmVwzNj/VGqASdEtHEO+L+XBHGMzbyxtJMamZonRo1LnpEYQSoaEwJ7AkG
         BVvtKPrmWPznPqtQHWY0igf7QyvLM3ejMF8PDTES8du0G4rAdrZ7CBDp8Yx2zp8qn/8p
         PajoIY8ZLbcQPvc1o8+xQBNFWEK9sHrmeln5wHJ5ecJ+EiQHsNlurjoM4qM94AAHlJVE
         QO/EAG7QlzFg293O12flYk0GgbffoLAAVgrgGx7GH6RMPJlURXRcPWFmqmUHVs97H1iM
         j6Gw==
X-Forwarded-Encrypted: i=1; AKwUvBxXY+3FmJfPYs5VrRCe6IsptfCMyM+qnios3dJ/H5MmkKO4fyqIXzCsaLNkRKWfFtNKQlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRnHXXJlSzTynM1EkxUZAAIVXgB1ovKIQ5twiwG7wNDDlhIwCt
	PYY3BDQymqhaZtIg+MMS8pzDPqRe7hYnGoVr76azgsluHOAWLQMFyz/DU6j4bAZ5NgXs52uV7sB
	cQ17hAA==
X-Received: from plie14.prod.google.com ([2002:a17:903:378e:b0:2df:ab33:9c53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd4b:b0:2dd:c053:d73e
 with SMTP id d9443c01a7336-2e49b6808ebmr23556415ad.37.1790975298845; Fri, 02
 Oct 2026 14:08:18 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:06:54 -0700
In-Reply-To: <20260905090912.40740-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260905090912.40740-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097515536.4084615.5338363103904700221.b4-ty@b4>
Subject: Re: [PATCH] Documentation: KVM: SEV: Use the uapi structure names
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="utf-8"

On Sat, 05 Sep 2026 11:09:12 +0200, Karl Mehltretter wrote:
> The document names struct kvm_sev_launch_update,
> struct kvm_sev_attestation, struct kvm_sev_launch_send_update_data and
> struct kvm_sev_launch_receive_update_data. None of them exists in
> arch/x86/include/uapi/asm/kvm.h; the structures are
> kvm_sev_launch_update_data, kvm_sev_attestation_report,
> kvm_sev_send_update_data and kvm_sev_receive_update_data.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] Documentation: KVM: SEV: Use the uapi structure names
      https://github.com/kvm-x86/linux/commit/fe02f37155c8

--
https://github.com/kvm-x86/linux/tree/next
