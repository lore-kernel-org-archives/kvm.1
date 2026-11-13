Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577735;
	b=RXyoLhK9RXW5wXDOwmVrQr4jakDR6oXPfaAHuI5bxp5SXgTfLCEmFrYk/ywHgWVP1MAd
	 Iqq0DlvZ1gyLprGtHNgVtikpf4WD+d22YLhG7LKYWzIwYN49TO44KnYeUqhR28xmeLUv6
	 Gl5LfQ4H9i2rgCInrnPFTzEG+sqfVLvWVjiOABNCsa7Jf8SmkEnUp3s3clTiXU2mbbS5s
	 W2Mze0ORVJMeABZj18PTZHBLnIIS7Ok7E2hHYS2486+JZ+lnGa/lYJQguuEaIRM5fdWP3
	 OXgs2uV5MyAF3YXnJVv4UoYW+K2hUDlH10aMJKnbc6nKHyoDKnVsFhrfi7AjvHMFveg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=f0mqUtjmtEKSM7QtosFwn7r3CB9yvkOYXENOb7wxAHc=;
	b=TIY0mbl6MzCqW0uazt+G3CZ3Ktj8s/Qi6oGbTuaHNc4UaSRwXnDUwIEXXBo9S45gbhKj
	 kztSIpeYRIk8BgH/xVITJ4Gmue0dEb5PEirMhJkdgpf0w6R2iW+FbLqqmLuCZhjahV+ZH
	 Erzosi1rvV/YhdlZDrOetOBrnwptkUSbr577sxgCb9xn3p/1dy996gQX32anoKIB4oTxK
	 cRd8EChmVV9v2oJRSLnkaG+av6mBEMxOo6lMyLlDwte2UMDCYrTedrrCaVjvjDZxPVnqf
	 N+nF83N66HQgh45PnZ4E1mQkfJi7AhcYaLTdpAx4yxIG1KkfCmzfHwyT3eIZxbRDGIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NKzQN7o1;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53178606A899
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53178606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NKzQN7o1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e942b1cc86so9465715ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577735; x=1795182535; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0mqUtjmtEKSM7QtosFwn7r3CB9yvkOYXENOb7wxAHc=;
        b=NKzQN7o1hq+eIgmzDRPEQXoBCBAb2DfPn1hLe1z5l/Zxra+wGxUmLA1nDviibkWXKv
         VfGm92w1nunOEygWaMWOGDlaMKEgUUP5TGvIywezSPmUlXFwdy3BncVSYXJ5nsTxgYgc
         pMaXlcQjRP7usGzcp6SG0GMQ4daQ76KB3fQslN+P1Kn/fOtAzDrmUmh4YelmtP4UWY3l
         ZFLpKb+RevlsEWhHkwqPXfUE/AKzbu5o0TAbU8XJRBEt9QRbDZ5/pRNRMYQYSBEtHSSa
         br3TUUrRFDxSKbWR2LUdgCUvI7PImGenUWSnh4UfUgT5uGIrrWTubqs9coPO4C3fr9KE
         /kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577735; x=1795182535;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0mqUtjmtEKSM7QtosFwn7r3CB9yvkOYXENOb7wxAHc=;
        b=sO6+RTezMA/FiCT7JMuxS5etyRenBZPlwHCmaeJJs3GrWpJiGJNRjvsL8AjcsD9U4w
         qqIwg7XpeY6915EMUvxznM5GgZgL3hMHk3D0d9NyTcaJJvabN3fu7x8EuSH0dnFBEr6n
         12aT1+jNFuNzLmz/izOmyzJDbLrCKCnY8MvlcslHR+Mu7E60drSdwbvDI3ukuJmJQAbY
         PFO+zVWdJXDsmZT8hZ9ZktGf+RD3B+83ChvEaCpQCPRMg4ZYNvJMEDCMj99DgKPu0sw5
         5Pgb+K1NSDhRY8LPgan/Vhv1tLUV/JfjpofY+gScceYcE0gz9n6AguUN/Ma1V/Mryuf2
         ZgCg==
X-Forwarded-Encrypted: i=1; AL+hErGekSPItcpObMJYZq4PaAoOhZTds4+/DOB3C6s91yN+f9SM9TbTwKvCp+/rzWB8dn6v3AE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QBEEbovFd3W+430YGzfzt9sUdchseHEhrqtSm53IGt7lol5D5
	3oR7z3VmAUGN8P4m1hLx2I0ZoSSkRoi6lGA4YgsMQvBYOk6iX9Zysb/3goHjhS0cFF677S9UVV9
	R7MyoZQ==
X-Received: from plka4.prod.google.com ([2002:a17:903:f84:b0:2e8:18c6:a093])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2cf:b0:2dd:ad73:5b68
 with SMTP id d9443c01a7336-2ee0dc933admr24674335ad.24.1794577734295; Fri, 13
 Nov 2026 05:48:54 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:32 -0800
In-Reply-To: <20261105000127.63664-1-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105000127.63664-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441817184.79877.1477945347866691080.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] KVM: Allocate small memslot metadata with kvzalloc()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Fred Griffoul <griffoul@gmail.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>, nh-open-source@amazon.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Nov 2026 00:01:25 +0000, Fred Griffoul wrote:
> From: Fred Griffoul <fgriffo@amazon.co.uk>
> 
> __vcalloc() makes every memslot metadata allocation at least one page,
> so small memslots waste most of their lpage_info and dirty bitmap, and
> memslots below 512 GiB waste most of a page on their 1 GiB lpage_info.
> Mushahid's patch [1] switched those arrays to kvcalloc(), and Sean
> suggested dedicated helpers for memslot metadata with a pivot that makes
> sense for KVM instead [2].
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/2] KVM: Add helpers to allocate memslot metadata
      https://github.com/kvm-x86/linux/commit/bd0ac62e682f
[2/2] KVM: Use kvzalloc() for memslot metadata that fits in a slab bucket
      https://github.com/kvm-x86/linux/commit/7a6d1004c2c5

--
https://github.com/kvm-x86/linux/tree/next
