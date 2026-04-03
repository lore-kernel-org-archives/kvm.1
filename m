Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43D3B6BFE
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229241; cv=none; b=kTIqgvNLpo6gdAtCXAB5KHwE2XFsKlpWLzURUFF0GqyusiM5rDoxF+hVa7a/QvfaY6OSvoxebnlak2zEsdplgknptJ6Offfe26wYb6O1FLbi+E9bJLGf/R+6IgSWDx9OzJKzQ9NpKBdTbepdV+zYOVsUwtVc5wgJnqK0x1WGZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229241; c=relaxed/simple;
	bh=5JrNSlRHOg8wwioSLtW+I0x4Uv4YtpxtksqlzhAX9Iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iWQ3xAO5MxtoxSRvwvVU3sSMTLgdQP6N1ZOj20R7W34VnbH6fwc+b6MUPXz/VFjShmb6LGrBmlEeR6bhr1NbxMazkK/2DhMqn4Hs1/yC/CJeGHqDpxo1m2Jy4Uh6wOXxnIW3JLaizMQjknWwqynf3urVDBpoVxHmNsbMXwlzrgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brBuVoQk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brBuVoQk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce0a9e125so1322412b3a.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229239; x=1775834039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AktZPj4NyJr6Phbu0f3MXPjy4WglY+n+w0D2Hnu9nnY=;
        b=brBuVoQkb+oBiPQnn8smzGO16pfT8FkxjpBUe6PyFmZwX6FMkV7orQoX0/Kd7BAAi8
         ZdaWne9aK+HuHPhQOKh2466Ltvhc/BUi8fSGKVsAxVuJ6wx2anOwa/jfw6SGdgvZkPxn
         BC36Uem+wKyI1sE52wfdjWPYKTz/k/pTXyOF9MDg3C6hotNWLW9+23QztVJt6H0TqUfi
         HKOKssIXncgdmaAh+2N/nv9ra9yiSewu7Q8nLqHu9Yk4AI92J+ITK8kYI08y0wbGk+EH
         fbmADrzphOFiKU3kpwD++BT/RFSIzfLNBfcm2ZCuMYsrRg1ZCuwOld2Dypmb3Hw/pOO1
         sRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229239; x=1775834039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AktZPj4NyJr6Phbu0f3MXPjy4WglY+n+w0D2Hnu9nnY=;
        b=OTj0NcjVz0o7yuhlMH4Plb3p/mvpXRy5+7JcIRwQk6m8jLlyZuVT2aD47ZvEcbumeP
         aXa+8v0XW/ZCVY3+Aklv3ybYZbaCeyvABZWyIBwC9pv++2vP//zRaxKEV1OeueO5pFd0
         0MUSureSjq2MBpSNCrZz2A7QXOzCnSOd2k9FtTgtQGsf/byg5N+yGgFdLaUud2bMxKNx
         SfFoDLibCygbxr4xUljTFaXvOzbWCREj/GVB5eCFczX9AH3F/QQBCuh8QhBDaJnOFvyT
         z59v27IjBQ+rPkToDeWQxfdLWKx4JPbdDVTuj9He+MSzXiTRnPlDkYTLBaD1kuEboeUO
         bqJA==
X-Forwarded-Encrypted: i=1; AJvYcCWcdIFKHSZJMFiD4dgblsfGz7E/9mt5c+7Ol1e7a34TdOENLKZ4J2ZZKaVgIKgcES4daAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLztJAHJYMn5hRQf71HLviIzfNzMfc+SPDc8NNcyQ7e5foCQIM
	Zl5aqi0Mzch1orvSVM3wGJwz1DoF2BhELFDwaGteodr5kSWjWWRC+07uF8WQu/97I4tqXu07sfC
	qVeCLQQ==
X-Received: from pfbik10.prod.google.com ([2002:a05:6a00:8d0a:b0:82c:2477:2e24])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab85:b0:82c:212a:a9b5
 with SMTP id d2e1a72fcca58-82d0db53fbcmr3125171b3a.36.1775229239267; Fri, 03
 Apr 2026 08:13:59 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:42 -0700
In-Reply-To: <3abaf6aefd6e5efeff3b860ac38421d9dec908db.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aaa7ac93db25459fa5a629d0da5abf13e93d8301.camel@infradead.org>
 <da02314c-e6da-4d9e-a2c8-cd3ee096bc0c@embeddedor.com> <97d40dd0e6abaf28f43d4d8ccf9c547a16c52e33.camel@infradead.org>
 <aanNPwnH7l-j61Ds@google.com> <4746a98c3390aab3d5f561dbcd0ce9d14266f003.camel@infradead.org>
 <aanaL-LA4gwTaSH4@google.com> <3abaf6aefd6e5efeff3b860ac38421d9dec908db.camel@infradead.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522837217.289969.17275629242412206815.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI
 structures with VLAs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, David Woodhouse <dwmw2@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, daniel@iogearbox.net, gustavoars@kernel.org, 
	jgg@ziepe.ca, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Mar 2026 20:49:55 +0100, David Woodhouse wrote:
> Commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
> flexible-array members") broke the userspace API for C++.
> 
> These structures ending in VLAs are typically a *header*, which can be
> followed by an arbitrary number of entries. Userspace typically creates
> a larger structure with some non-zero number of entries, for example in
> QEMU's kvm_arch_get_supported_msr_feature():
> 
> [...]

Applied to kvm-x86 fixes, way back on March 12th (i.e. this has been in -next
for several weeks).  Thanks!

[1/1] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs
      https://github.com/kvm-x86/linux/commit/2619da73bb2f

--
https://github.com/kvm-x86/linux/tree/next
