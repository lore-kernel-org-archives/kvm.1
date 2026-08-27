Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44027CCE0
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806106; cv=none; b=mIurUIdoG1OZb84mB0pXO4CaaE2eim8b/qi9Y2/Od5QXj1CdXVoXytF8DhI/96+eqJMMCrjf3dmGUBk4nTpsAq09IZpbttW28c6GkHYVj4xz3QRiodRuD2J6v8pMd2BjqiioLfhbHbQHas4It0OUbYQgkCkDqhihve3QfWJgnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806106; c=relaxed/simple;
	bh=WJu5HTRzik9JIFk2qriT0YD3wfvF9y0NeUb+PtTrNcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMYFLlVWgfed+fmEQ6qGWXCvQxopfE35L5MtN01KvF3qLutY4psf36qwu/6Kc1LnRf4huHSFhfUuDiG0M0Ttqjq9NdTc94AUXvxSrtR5dDMLPUjSoUw7qNl6bzo1V8sIEIoPi8Oav1fcNJtA2wK/Qekf63Hy75l4Ch2Cw5XoBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdYmGhNz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdYmGhNz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d71a50caa9so12949895ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787806104; x=1788410904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qi+er7bYOUcgVSzA3zCVsVfsxzfy0NpHAMb4Vh1V6sk=;
        b=qdYmGhNzWZj3sd+6XDpTQXm9sLtLQBwkDcIiIc6xIRVQknuolCrBFKiHtiUTmhoyZx
         CD6czn9OXcNW+T5wnY7lqXuETFMsUZTqc26szmqL4coK/3qUc/4RUxicifKPzkGeYOGd
         pwVlm9ESeBeoXsQQqEkpiZxdDLa+eqTYL7pTu+MeR1E9AHik0mwzbocNraI+vQ4fbY3p
         T2EYgq0wNYdJkBlSbThBSfiV2XCjTnkSqfXa0acU89ALR/0VuyH/CzXjci2Owrd6tMeZ
         dVRZAu2LioKnoPjjlPyty3X7WbysQFbcwDWxFMsxkNUnrN9RD6pXIIdyY8Bdj5ZRxGpf
         mifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787806104; x=1788410904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qi+er7bYOUcgVSzA3zCVsVfsxzfy0NpHAMb4Vh1V6sk=;
        b=DdCh7jX7AhN1K/hWj1W8rKyq8teTccgNe3Im7G11JJ1poCqTQTSjjDPm3yWaKNoQg7
         veTYlhKcECa2A0JdLunpf1OtJ/97nGZ42N2WWT1b0Kx9PgptStzmL5JdKXuzy+dXMjvk
         zbXvJT4t4D9cNV+sQ0qBEZI0anmYItlmXs2AXrRY7177+lMoxI68CA+EWHQazXnIW5Sk
         sdOV+608SZT/11JA20G7enBuWHjOTkIJssrCILOd/NKAyUYriabvUvN5yG8a0x4sIzYq
         Djzb3f67krXlHvt2LWcr5NgCF7wffr47W+iPDgSLPwTlUR9+KC5BLtidNybuTsOS8tto
         KkrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcjrESLvGeqpCiLCxAUvdfRjo7ilLiYY99G93tFDGtHQyK4Clrr9zBvRbO+iraNRHntrc=@vger.kernel.org
X-Gm-Message-State: AFuF++nTP+/5hQCcjUpoVUVTioDDau6kvCwCjwxRA/XBisDCnEQEmCPY
	lp3dBmfxvifJEZEzBoWmZ5HV5XX/bBLecKjtiQQfgZLrSObmTpRkjCb+XP2Q6FaM
X-Gm-Gg: AR+sD13PmAZQgw5HLCFtXmUnszdBQLJJnZcZb0gghjRCvI9vOVfNtwUOIYxWece7zSi
	UHnjm+8OYP9C8ny81xbs/ZCVXZx8GVTP6R6sWkS2u8DbcNZ9OHj2c8ybzsUu6ebHaCkGLGx7JOn
	0ch/0xCNcBmO2P8ihDp1pUYKuYzkD0qJkqSmLnA81JAjn6VWbn672qnz3vBs3oyXbqjsHWvi7XL
	hO9yBbrAPGmIu40drTHB8AkMCKQ4sE2OGf33FJ0BDJhwoogqxbLMPDPjdgNwBNJlAnr9fNcxZOX
	7jSMqlfyqV6M9f/4axiET8iTqc4v2NaoLVz4fGx4SHHT0xMSWvu8SkUOe9xjy94NDOVlPqLhwRQ
	yjjQRgf8ryrttGvrIKul/yQVQoks/b9bkyT+nkhHXSqkYTR5KsR9Fmdo1IR5RY9NkwnzSqjRWXT
	jw5hqznnwS4rlInrhJ38stFqQOSLmzy3DiJ8zXLlUwWmgq7ibj4H9fvM8LX20gDC5IWjbKeosGh
	lMyeYCNeOc=
X-Received: by 2002:a17:903:230d:b0:2d7:1e07:4859 with SMTP id d9443c01a7336-2d71e074bf5mr102128985ad.2.1787806104347;
        Wed, 26 Aug 2026 21:48:24 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d9e5fb1sm23000756eec.25.2026.08.26.21.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:48:23 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: selftests: Add a helper to read a vCPU's APIC ID
Date: Thu, 27 Aug 2026 10:18:00 +0530
Message-ID: <20260827044800.2917294-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260826115915.2882221-1-hemanth.selam@gmail.com>
References: <20260826115915.2882221-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please skip this version, the report is right: the helper applied the xAPIC
shift and mask unconditionally, so it returned 0 for a vCPU in x2APIC mode
on a VM that enabled KVM_X2APIC_API_USE_32BIT_IDS, and truncated IDs above
255.

v3 handles both modes and I checked it against every way KVM reports an ID,
including a vCPU with ID 300 and a guest that renames its own xAPIC ID:

  https://lore.kernel.org/all/20260827044534.2900285-1-hemanth.selam@gmail.com

Hemanth
