Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182C30569F
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975341; cv=none; b=Yy0M8WRccCKqGWpPa4Nu42CoFf/XT3gty+Ns80SQj6sjioAnIqCEb/N/rTAxQdRoSqloqsPu4W+99jxU7CAT0+WaDuRxD3brjDlR20oySNrFBsnwaxYnjidIisj7bdcoILRqBwrPZh1Ys1c9TZ2Eid5N8k+ap8kC46rRNrtkr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975341; c=relaxed/simple;
	bh=DRhIYyZZN7WiAtU4Ll0e6lnDDxpEQxdAaqhVQan1cfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LEJiZa5Bi9Ig5GpHXqvEUNxpA8l3jmQxzO98Ger+6V7+TuiUUdc/IcePQInDGFPes7c1DAll1YWaJIfOhWWY/aR9NUVeWB8y0AW2XDYrqa5zg8nYQjzd9MQEWsU1/EI/LUxjIqUyvnpqSBTTu6GtldroqcfbNRGP9qIUIOECXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sfk8IzpT; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sfk8IzpT"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso16312a12.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975340; x=1791580140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ttj3sFWSEnF9bKkFFkERtt9KfbPvVDW8TfmnS1SN4Ec=;
        b=Sfk8IzpTovCmog8QwTh++lgGCEyUw+cFiHfhswmf2rnqRL5zPJ5EmDazK68JuY0Caq
         trd5E99iLoJGQH3MpMBF7fIW3aDdWcDBdXQ5Z0qLyHd6RpRFPE4/VNrro9e2mfi98xrT
         lTwU6PpYm7QhZKZmbdOpOfJsPDhUlOXFToRQSAZGV2LEK8ZOpvhkoEIGb8JzwQuRcvT1
         hUFCBdrS6NBaKzlVTxKIPrdX7EMRc+WQVcy0s9H3npBDqrEpOJmN0DomSNA5I4N7tvSg
         oNuvPvu15UDNzUQtXILLG+e2fL4awmsjJKOAc5Vc/Ot2otP8S/VQFnHF0Qapm1mKz13K
         fEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975340; x=1791580140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ttj3sFWSEnF9bKkFFkERtt9KfbPvVDW8TfmnS1SN4Ec=;
        b=XdtO2qyailpvBXEfhFoTDGDmdP6HxdGCFK+mt+4DcqJLNPnPp1oNg2nrPbpTN0lDkw
         DU9oQFIZZGCAXmUQr/EKUdN5cocFLDPVJJOn7XbcnjRZfJVunxkkTvzN0Y0kcFszDhAw
         YbMngu2noVpZewQNGsnN8vrYtimvQIDg0IGakx9M+m5EqVsmV1FI7D0I/OVowfiXcRVh
         Xi5kmUCe8uAIK0SQ85J5iew6R7mawTtpWPrhQZCmpYbXWSLfOTklHs9zgKxl4mGeEcc1
         +OnZTfVsAzJ5rhC5PMzIde1/vShE3kEbR2Txrr7LX3Ig7/YWjGAmWRXG5dk21TXHi9WO
         Pezw==
X-Gm-Message-State: AFuF++ne3u7OEvu6BTTtvHk1aI/0PSlgLBLY/+3apHLFFRHHZyjjw2Ll
	9DvZQqzuuJDXefUk+zWUtaHzBAOPqMWKDec8tF2PPdz8dc9+gZRaJBikFmnmCEzo49/MqWUKxd2
	Qug5EbQ==
X-Received: from pfrg18.prod.google.com ([2002:aa7:9f12:0:b0:886:d067:aa33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:ed0e:b0:3dd:a196:3091
 with SMTP id adf61e73a8af0-3e0bd42d56amr3863146637.65.1790975339691; Fri, 02
 Oct 2026 14:08:59 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:08 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097462681.4066567.295128970891612900.b4-ty@b4>
Subject: Re: [PATCH v6 00/12] KVM: x86: Bus Lock Detect fixes and SVM support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 30 Sep 2026 12:36:22 -0700, Sean Christopherson wrote:
> Fix KVM's handling of DR6.BLD, and add support for virtualizing BLD on SVM.
> KUT tests: https://lore.kernel.org/all/20260925230003.2362261-1-seanjc@google.com
> 
> v6:
>  - Throw in the towel, at least for now, on WARNing if KVM sees a DR6 without
>    all of the fixed-1 bits set. [Sashiko]
> 
> [...]

Applied to kvm-x86 misc, thanks!

[01/12] KVM: x86: Preserve DR6.BLD (Bus Lock Detect) when delivering #DB payload
        https://github.com/kvm-x86/linux/commit/719a1d58bf43
[02/12] KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
        https://github.com/kvm-x86/linux/commit/cc551e8d4f77
[03/12] KVM: Return an "unsigned long", not "u64" for the fixed-1 DR6 bits
        https://github.com/kvm-x86/linux/commit/28bb033664ee
[04/12] KVM: x86: Force fixed-1 bits in DR6 after synchronizing with hardware
        https://github.com/kvm-x86/linux/commit/7b88577a0983
[05/12] KVM: x86: Set guest's fixed-1 DR6 bits when delivering #DB payload
        https://github.com/kvm-x86/linux/commit/c62ffee78db8
[06/12] KVM: x86: Kill off DR6_FIXED_1 to prevent future misuse
        https://github.com/kvm-x86/linux/commit/0e2342b02380
[07/12] KVM: SVM: Add helper to query if LBR virtualization needs to be enabled
        https://github.com/kvm-x86/linux/commit/7faa73133e40
[08/12] KVM: nSVM: Disable LBRV in nested control cache when unsupported
        https://github.com/kvm-x86/linux/commit/5cb0577b7497
[09/12] KVM: nSVM: Open code check on LBR virtualization being enabled in vmcb12
        https://github.com/kvm-x86/linux/commit/cab4449bddbd
[10/12] KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1
        https://github.com/kvm-x86/linux/commit/39080c3ca8b1
[11/12] KVM: SVM: Add a vCPU-aware helper to get supported DEBUGCTL bits
        https://github.com/kvm-x86/linux/commit/cd0e6f4d7cec
[12/12] KVM: SVM: Add support for virtualizating Bus Lock Detect
        https://github.com/kvm-x86/linux/commit/62ad461079e7

--
https://github.com/kvm-x86/linux/tree/next
