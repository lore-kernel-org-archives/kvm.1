Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100127;
	b=0i8Y9CZ4ervK3ZcL9+XVtaqKEoupjplB1vRPVuCn1SMrXqBIVBwLoCtcpa3ibGv6ml21
	 ft9IiZEHn0/GYpDFMVYTs2mKznB2c2nniBUu5eNpxWzUmSh+oAP4eRwcXud+4rlxRtPq9
	 YGAjzmGDD3+HeQHk3VJoc9PNB8nsU5u1RFVdzo8QflG38gl25A3aTh6tSLRs67qkliJOB
	 pTneGzSp9GUGN8bNrR+J5U74jpUQC7x0mUuj50qL1DFqqJ7bAIg7Ay9yc/OEKlRvmCJlR
	 aUOxYJ54sQqnMhbE9tVkNCaQQ9ZbFloz/N6M7/QXWgXpC2pVTGpUyJF1JWf8ruto1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=S+oxTAcNImzeaYdPGDfS3qQV6ylfKK/6QUzCHVinTiM=;
	b=DJX57hFh8HwxHveRYKHxJag3f3GeCXFc8bzJ+Wuguw8V6mMlk32RLyR8JD1TnPIDdRa1
	 /ilf19KPS/VCwbQSqJ85LjF2BtedupfxDscSYN/ScHULWwzO6jL+SNJbbEiUAi39PwHXS
	 XHeP8gIY9dfxEf6UxVMFf48Zzdk5e5vFxICuZboCvgKxGVl3ZlGelU4GlVJkaFv+W1f2+
	 60IuzEylmn24SuiYcKECHP9ELK1AHauWtBbB2QaotHp2s8ITiX7EZUHLK3eV9x9d1Q7im
	 9Y4dlPHWev56zgpZ2IkD7l81FZXtUGRrtWKBE8xzScchSQVCxRvZnfgHMUkBDYzKAgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0Zq+bIM;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E6606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB0E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0Zq+bIM
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso26114715e9.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793100125; x=1793704925; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S+oxTAcNImzeaYdPGDfS3qQV6ylfKK/6QUzCHVinTiM=;
        b=i0Zq+bIMGRTxaB0lxodBl4I5ksR0aHr81nLQefHJ+StMFbUjWPwq8JmS4SijvW3UV/
         3mGs6fNNmUTaI65N+9d40N1vJ6axmpyB5FzcNUziodrMHfdAY8+hpKDE2nZptxpr8+D/
         PRtp2/p4beyBZGrt2AScOv44NhBNcFbshgdQReNkQPEzGmYAg6BAzDrVB+gp1KxEQ1jJ
         PYwG99Q597emcPUGNoc5pojkhxAD98VXB+569B8SzRNqEm7XyO0Dw/ZZN1HabQpvEElC
         ix7MJFiDrJndMFZzvSewUyMA2+MxbU9/iICoIhdav+cPJDoES4ALouMRovimHEHUFUux
         cEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100125; x=1793704925;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+oxTAcNImzeaYdPGDfS3qQV6ylfKK/6QUzCHVinTiM=;
        b=gdZ9xWSsinpgnO2JGNHKSyqv13e0sPwt8yieBbhKqCmKmHeYWPKdhzMbujiSuA+PIZ
         WW2uwbp1CkGlxhpeKjNL0PT6gLsDGI3Czqk/Ljvh3ntCL5N8LXYash4tUJzFb+A2kNVq
         Bwh9vsCw9NGhITnN7QSHvOVJqS7MI+JNW/3fDj6vRLjb5H6CfhD4sF5eps5O7HwwBmBo
         3mzOlKZxWsc9zq7ThLUOBkXQGI3YJMJ/jHCVszRTXtYaQpn+9TznUGfy9MQ9egVBfEh6
         atYfyAbj1yzzYfZVxoCHBoiitbXxyqV5AgEGrx4SlhaY5dP3MGf5Wfhw1xnhdhkAq6hE
         UNcw==
X-Forwarded-Encrypted: i=1; AKwUvByiyflrsy4FKr8K9gMnBY1gclauHpLKiBwpgBfOpFfKMbUY+k3N89yrfssFqlPSKdzCt5o=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7R9LzBDDj5J7WXZ18e17vw07HJ96cltoV0Mk7Ya3vyvw1V1Rv
	z4L4KGkIGMOH8nsdn5aGl1Y2NWYKJ9R7cy3E5oGtdu87CbQZpvlmkkOXibUNFUfg
X-Gm-Gg: AYBFou3gqSdLI9xJPqKQ8fUriUr+VgmjJPg45Az+7gRKPyMu9hyvjA58Wd/mKlnmEhC
	pT3mdv0TxTXF2CYbjwF25meeMOI1FLQLXESBm93rF0nuS68+7D2zjWkrrrTtlgH5d+hH+aCi1hq
	cuKOi/C728fItY2Dd/jjHd+rxxZxN+ZK9+UMgaUFq6qN3WKlBK6ZDmvRwT+H7ThEDQ8odSShMu4
	glqUuNEs8uA8FjzrC+KpIVnOQOPd3dBWoIw+Fm4IiBXga3lvoAQMRW39y8PG4DSk+icre/zx0zL
	hKKsgCfx69L3yM7xU1cJSJTfvd2s0YZPS2VXgnYIqX2u4uawGAEe9uAzl3jPz7gzrovbVca2ilA
	q7Z9FMW8EcyN3MF43CkGEK5G2/pRS1/afRnY+1PEn+I2PfB9myvJTzeRaEz5pd5GI9+sgt6Z2OP
	Ttz7scT6mjE8dd7BNixvUFqDTZ+RhGMAZAmwIthP0pVzz2wDnk/b9GDS1hKiqRQVzcRoUdWO23Y
	na9QbrAaZi+aaF8It7K3P11t/DcDkHwiEFcSd/fH5btImy+loPJAtBe/Ogw1iF8fIzmugODWwCo
	rmoh0Zlwz+LpVZzfOKC7rlz6jj23xOM=
X-Received: by 2002:a05:600c:8b66:b0:4a2:a8c:22b0 with SMTP id 5b1f17b1804b1-4a35ac3b3d9mr175224955e9.1.1793100124941;
        Tue, 27 Oct 2026 04:22:04 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f59750sm175005495e9.0.2026.10.27.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:22:04 -0700 (PDT)
Message-ID: <6ae0895c.42cbc100.1c0cce.9e1e@mx.google.com>
Date: Tue, 27 Oct 2026 04:22:04 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Subject:
 Re: [PATCH v2 0/7] vfio: mmap()/mprotect() hygiene for MMIO region mappings
In-Reply-To: <20260929143621.540f0024@shazbot.org>
References: <20260929094848.7439-1-suruurism@gmail.com>
 <20260929143621.540f0024@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Alex,

Thanks again for applying the vfio mmap()/mprotect() series for 7.4. I
have one process question about stable backports.

Patches 1-3 (vfio/platform, vfio/fsl-mc, vfio/cdx: prevent read-only
region mappings from becoming writable) still carry their Fixes tags.
They are the same VM_MAYWRITE/mprotect class as CVE-2026-68445
(drm/vc4) and CVE-2026-80724 (ptp/vmclock), and I am tracking the class
as a security fix. Would you like those three to carry
Cc: stable@vger.kernel.org so they can be backported once they reach
mainline, or do you prefer to keep the whole series 7.4-only?

I understand patches 4-7 were deliberately framed as hygiene (Fixes tags
dropped) and I am not asking for those to be marked stable. I am just
clarifying the intent for 1-3 so I follow the right process.

If you prefer 7.4-only, no change to the applied patches is needed.

Thanks,
Abdifatah Suruur
suruurism@gmail.com
