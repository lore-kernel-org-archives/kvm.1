Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650A547048
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999594; cv=none; b=kErjCEn5HwrOK80QC1bZ7pgV66nFId+kQxa9TNZDNkYS2/nRdAjAb7hNm6r1h2hxQERElzyVAp97U5AnuijpUg0clsleyv4p3d/FI14LYRdmBD+/84FWG0XFSGZ68PBnteozNF4VnpKAa7frMIMHeJ5oCDGarBGIw0PgWRheKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999594; c=relaxed/simple;
	bh=OzuuWVIqtaFd/YYFW4xK7+t91VemYX3wot5lc8ID+mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8Ull3AB1WEFSLjEbxHqOpNX0frK498Zk1QF8JvoJkysEfm9gV/6j4rHEoWgS1Mo22Ab/fjooux4oUEwRTro1RDc3DayHx2fF0IdL8rChNtOzdiFJO60Cnj9vZaXDA10kOXFrATpmtZlJKGpDyt2YU8bWCLCF19qrVB4KzQ0290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2APeTW1; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2APeTW1"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8633c0d7353so3234274b3a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999592; x=1790604392; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZN6pn1oKVfiJrGbRYveJPh3MZHL0XDj4nwpj69nUOA=;
        b=P2APeTW1AXaGq/Qi+t0Vi8GeDhueXF25n3yQUW+TuoYgtlVlLXgm1iPOAlErXNQupI
         SC3qZrQy7aN6c4PzTB3/d4cxXO2VX6cKIGi0AXHrRLRdY0cH++ssmDGvrOMEaB3FT6Ci
         bkOSdOHantkcimvNEhA3Cuzd1EsaLKikDDM9vzA5iZUbNamfQKcOdTLClf5fZxkAcL2F
         xaMCGrJ2mPmdCQ7DE0msiCa4u+DeWF0H0MvCeAMDut4ULwY2wFfJIMFa3LqeLyAmJ3hu
         IQLgFCbYbuQZWh5/sl1qmylcu9rOXcQ1vTdtJawPXZE62lHQQfSHRynSEu+QeEhatwUR
         G1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999592; x=1790604392;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZN6pn1oKVfiJrGbRYveJPh3MZHL0XDj4nwpj69nUOA=;
        b=OSssMrdnutM+EgziMzwf1SDyMqpR/9nkdx3nMWF/bHQnVTBbkMPKj6RrOBOzxbptBy
         xXqcjwiV7wKtQx3eQ/uHn8FaugSPNG5gp1z21wd9/ohDP4HXp1ZP2iPY3v7HaQ+ag+Z6
         YsUkSmEVPuepnYAsJXp9QRCZT4jASbsumRJwgV8FL2i/DT+NInxCnQfcpP8Glb6DO4Bu
         YfBRkM8nKBXEX/caqKtY1FLDNnW/INqtNIaQF5ZPDETjTVamkF1a7Hz0uqc1R+PsYzya
         zFr6kvZcf55km4IXnhhFZapDQp9lWd0/xKOpTysUhzizyP+IkABpO/nSUmpK2eXDkDJv
         VqEw==
X-Forwarded-Encrypted: i=1; AKwUvBxzxGbcRiAKSFQKFVwZEeN1waB1K7Pq18totbHuvLP+IFnfUvI2gmDhNynMdhumSvU+AfY=@vger.kernel.org
X-Gm-Message-State: AFuF++n7oSTg+XwYHUJ/A9QWIAI44nPVuOGkdwH9ltISMazYFhFZxzeA
	jI/Bh+OxVYtR+U51Jl5Mw2Lv3VT0EGo/4VJqF73KlJrv+w1Tsr3mWu7RjYoeqpV1MvAGKZf8zl7
	cOodSrQ==
X-Received: from pfbdl11.prod.google.com ([2002:a05:6a00:490b:b0:879:66b7:29a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2443:b0:3d3:ae1f:d7f5
 with SMTP id adf61e73a8af0-3dd8c4ff268mr16788092637.21.1789999592068; Mon, 21
 Sep 2026 07:06:32 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:16 -0700
In-Reply-To: <20260908160426.6547-1-tharitt97@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908160426.6547-1-tharitt97@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999676410.711234.12909851740804144889.b4-ty@google.com>
Subject: Re: [PATCH v1 0/2] KVM: x86: cr8 reserved bit check
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	shuah@kernel.org, Tharit Tangkijwanichakul <tharitt97@gmail.com>
Cc: hpa@zytor.com, binbin.wu@linux.intel.com, kai.huang@intel.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl
Content-Type: text/plain; charset="utf-8"

On Tue, 08 Sep 2026 23:04:24 +0700, Tharit Tangkijwanichakul wrote:
> kvm_is_valid_sregs() validates the incoming CR0, CR4, and efer values on
> KVM_SET_SREGS but never checks CR8. When userspace passes a CR8 value with
> any reserved bit [63:4] set, __set_sregs_common() forwards it to
> kvm_set_cr8(), which rejects the reserved bits and returns early. That
> return value is not checked, so the ioctl reports success while the
> requested value is silently dropped, and a subsequent KVM_GET_SREGS then
> returns a CR8 different from the one userspace believed it had written.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Reject reserved CR8 bits in KVM_SET_SREGS
      https://github.com/kvm-x86/linux/commit/3e7a842fe533
[2/2] KVM: selftests: Add CR8 reserved-bit checks to set_sregs_test
      https://github.com/kvm-x86/linux/commit/2b0e0aa54fa2

--
https://github.com/kvm-x86/linux/tree/next
