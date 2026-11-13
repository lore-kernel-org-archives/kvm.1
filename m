Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577768;
	b=CKBg1Pm2WV9wbc4iCd3RT4KFJ16o70t7aQqjOkEIHeFE1nXMRbeIkFg28SHTO7C0aHgG
	 maNldWvtXYx0OFHGbzqUG/VnK2YXnW7j/nCvtyWHRbvvOpoJIM7gygYv7OQGcBdhY7GqV
	 2LxPduqxKmfa5aG4FBA7rGrzYt+t5agkBNw7w8DSTDRd5W4CeLjBAA3tvWEbiT9KCozZF
	 uSkvlYTOFgij1CfaSTtgcXzRw4uiw5vKGPrPOd/4HsMpSw9elizz+9SmcPUxKv0Y4N5La
	 5/XfvRVl8k4ggsxpoSciPtOqAu4vihcvruxYO5R6D9t5crqrqlfR4tHm0zYkJBSDDqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3v73r32eIAJAgWPi1LsXT3feGTevyTVBk7sdUb/TcA8=;
	b=xIViLw2lNBANqwKb+OBOCdRHQxlAlF5qSY/w+Of/s3TJuzErN3K2lYUoKUAUocWE5Ehu
	 5HAizL2OoI2TJLkTa+qxR1fXMqdNge+Aka+2MB9qFGYgriPAUe8BOf+Hp98dZ8au2/PjI
	 i2E7WH4Q4meAK+gtIaCD9uFO7MPvtoRtcgNKPihXBBbUznJ+hIQpaQAAHYMzrsafrRATS
	 f4E1w0ggTtvkR0mY4W7WGyfJYRTiCRsSfkM03EL8t9AwVV5knotUQgRkkZzoo1E+t4Fvl
	 KA4czGVHZinHmQ1HbzslVAmKU8TfCgS3DxWkoF+GSxSy009srbhggDpzwBubPocYGpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iYprxckR;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8796606A8B4
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8796606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iYprxckR
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso695349a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577767; x=1795182567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3v73r32eIAJAgWPi1LsXT3feGTevyTVBk7sdUb/TcA8=;
        b=iYprxckRt6x0jveQ7KIO6R+oa6tFiYQfSlMcbZeYNkZElf1SB6bHrK9uNemcL5oERW
         JhBhmjD7LEkzuwclSSGtFi8rLnFij9YqELQAndFPhuWI9gCQC10TQDtD8DoiOnpSH0j2
         HVjFKRqbxI13gzT/MYxeD/jL8356LwhFULpVEx6CDY8d5wA1hfQQpOq6O4L8pqpiDPp6
         HbI63zWl1Ozdh3NXXVXkDOnJO/DgRq1C2QmRF0R3mwzq5LUSDPowEpJb4meLFazbRWGf
         Ez8ljTE+47qpn1tkWgbwYUJo1cThf1QiMHn3kI1ljYZOpvksMa5d85Mf4VwYBml1Ckrq
         a5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577767; x=1795182567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3v73r32eIAJAgWPi1LsXT3feGTevyTVBk7sdUb/TcA8=;
        b=Ph7eW5kjjUH2F+c3CKkF9IZwIUQldOr41RA8oG8OcyyIha4BfXCfAz9pOpyoYFKPOl
         svn1JkH3B488NOms46P8YaZpKc/PUOh6DN3iHEW7BsrwLqcnyfdOJRJdSKBVFAcWmHJe
         3ZQ5zLGGu5yb7gar80DRgq/OvOru1TGdrl+wC+zGIP3gsOF6qm4447fLwPwvzQiQew4Q
         64o1B5BLhmWGja7jhYXZX1IslB5NMvJ1zY4pENuqLL88nlT5lkec15tLtjhgQH0iH7TJ
         4SKp+1IEXLOGMBxnTbwkMiOSgB+Vq7fL1d6vvpKScODJTbXhOCz7LcnCsQ+MVw+OnbCn
         jfEA==
X-Forwarded-Encrypted: i=1; AL+hErGMtQqZg0u1ygQfxFRe8FZfdLr9IJJZkp+nY0qx5DJsELCeHvkOKiVmuLtpNjwVbpinpDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Sdrwo4I9JXzDDASbf6kx7FjDNg/7MPPe5YuNMBLA5x2nh6Fye
	THX6HMTapGXM9N2RCeMmGWyE7XZygtkilWUJLwzEk1d2SkhwjlDHKMCOQxRonxNyjh4h0hfvXwZ
	GVmn4qQ==
X-Received: from pga12.prod.google.com ([2002:a05:6a02:4f8c:b0:cca:d82:9104])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c8:b0:3ac:7842:bd50
 with SMTP id 98e67ed59e1d1-3b1b0a428admr2241920a91.15.1794577767011; Fri, 13
 Nov 2026 05:49:27 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:40 -0800
In-Reply-To: <20260731150846.1728164-1-dmaluka@chromium.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260731150846.1728164-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441846682.83214.17243719876978660073.b4-ty@b4>
Subject: Re: [PATCH v2 0/4] KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Dmytro Maluka <dmaluka@chromium.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Mathias Krause <minipli@grsecurity.net>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>, 
	Aashish Sharma <aashish@aashishsharma.net>, Grzegorz Jaszczyk <jaszczyk@chromium.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 31 Jul 2026 15:08:41 +0000, Dmytro Maluka wrote:
> max_vcpu_ids and KVM_CAP_MAX_VCPU_ID are exclusive, i.e. the maximum
> allowed vcpu_id value is max_vcpu_ids minus one, not max_vcpu_ids.
> 
> Fix the sanity checks for KVM_SET_BOOT_CPU_ID and KVM_CAP_MAX_VCPU_ID
> and the selftests for them (added in series [1]) to fail when
> bsp_vcpu_id is incorrectly set to max_vcpu_ids, not to a value below
> max_vcpu_ids.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/4] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive
      https://github.com/kvm-x86/linux/commit/9b04ebe5c085
[2/4] KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
      https://github.com/kvm-x86/linux/commit/c36d436e7335
[3/4] KVM: selftests: Improve bsp_vcpu_id and max_vcpu_ids out-of-bound tests
      https://github.com/kvm-x86/linux/commit/201aaeb1df8f
[4/4] Documentation: KVM: Clarify that KVM_CAP_MAX_VCPU_ID is exclusive
      https://github.com/kvm-x86/linux/commit/ea6d489ae6c2

--
https://github.com/kvm-x86/linux/tree/next
