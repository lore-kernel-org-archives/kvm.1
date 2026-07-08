Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E363E169E
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496745; cv=none; b=T9IrjDx8+8X5CaNEsbRrVdcb+VGX0kcqeNHE+xX8tNHWnNsSauuDy1Pxy3BR/AC6FicBLOVx9XyT3JoVAdIkTIvden0FxzGFOGyR7WyOtwTPf7AxA4Jyp0RD29IK3UPFQr720WX4Ox0hDyZZI3ks8IDJ9llFjdGQkZmzi8HvCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496745; c=relaxed/simple;
	bh=eSXaeCqe2YPPoFRwU6X9uNlv+DTy2trUWTt6THz4cpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQwY4dZQwxIk6oYfLI0sOtDIros1rEt4yGUSdOBWAKnuGiVMSxU33I2iZyT+cqsaOwUCtH8BtzsRdYymzc+7kTEJWVjvetPnP05WcsjFMJTEC2/hIArSV12DD+N/egz9M0lsZg39SguSlQu9ncEaUGUpN4YHt7KHAS56qeZpZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4mTyQSD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4mTyQSD"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f236418so244507b3a.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496729; x=1784101529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSXaeCqe2YPPoFRwU6X9uNlv+DTy2trUWTt6THz4cpA=;
        b=o4mTyQSDBnU59jse/NEwF7pBG5kdvEjEivXDIAnAo/1fBEdXfGMrwC9Ll/AeocFX0R
         pMj6CN6CTwotqNqTDZPRBoEH9EGKUwj+86Ob0wGKm4OplKTvaEjL6whMIMPvRDs2G0wM
         IZ8yWAZL4srlJG6/USjhMg7c+UcVMl/A0RQnFmHZrAoe/0qH/s61C+Y6n7OPHVRkyu0U
         VeE+172Z7slMrJATysa1f5/7qgH2LJI65513EXk0sjoYpYzKGju4eNfV1Xv3NeVeZ+8W
         ifu6YRtcv8wXBpAyWNFXL5au7jPAg6m1uyV95sUnQvKSGaVlsadgh0qysjQNNHX8pPe4
         ndqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496729; x=1784101529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSXaeCqe2YPPoFRwU6X9uNlv+DTy2trUWTt6THz4cpA=;
        b=EvWI7mIrqfFs6bchU6te1ZyLFr2REB9RrOfN0BOHk6Ns6xaJpMywxnfpyhLOzEh4YU
         75NetBSAhq9EBIzPGx8Yh/R0G3gSVOEGV9bWOvvvv1MWyKWqCyuZiCfs7D73PNqHsYwU
         x1zoB3g0k7Ppm265dg63VyWKhVVyl77HysRTBAatiCiMEd0dOJMrZhlalcy86OIHmwX+
         w2602sGbqunY0cYEcnsZbHTGs7/+xVdDkfaUwE9nobkpayjNmd1KyRJZHM7D7wWq1py+
         ATsgBR7kHvHiKBL+lW/UnlHvXnr6wiA6oY2hWRHJnOekkD9cUEpf1hOD16retr31fgeu
         iQJw==
X-Forwarded-Encrypted: i=1; AHgh+RoXXH5hxnv+KW7+hFbnXayTECQLoII39psxh/IiIzycGrQ2YR496Z3Y3FdKpFrFTsPNWa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEKjM4gyUD7iDe7Y7fZQOCW/4zmkVUepBml1gYbDwrTh6a0KB
	psEM+w8Cwz354wlgbTVp+S9NhCaAwybqqKXi7q6w2KBOWmOgI/k7lY8X
X-Gm-Gg: AfdE7clW7Msi3yWwAAJ+YO+Wrm0hasSqaj3YyJLY+6efSo9nSpjwMXKoHmr9Kusyctb
	rxa1p6Joz1m/dhB1XHPY3Np/1FMiRhr7GRfeWFa4+mWaXzP9eo2shrHt5gZwd8zwVQojFrxg5R5
	/VXHA0LFRpiZXX/pVRIEFxbZOGnUFTGVb8DvUnU92naXYjy2Fh49WO2EgxIdE7GLygaTQwGYiVX
	wRC7EJR48aING92NxrnPWvdEPspeqe+yhxoCKbxzh4TsjlTGU/i5LTwCtSo/SNz7n4sC42HX4IJ
	JE5sfKJJIA3RbuxvcX7o+jXhczhW/FFCWp8p5LZbqqX87KhmcqkJdrzXlbeWamCus9Rtq6OUUIj
	Hl5c6hSXNdRA4sTs5SV28Vslo1tmy9AvBJVT5VjG+bbI2qRkAsTCGGjUXVBTyMv25sfFUUvfRy1
	K9eklzYHAs14NTmE56veyJAe/poiYyI7EW5QNamQ==
X-Received: by 2002:aa7:9062:0:b0:848:2f74:1d68 with SMTP id d2e1a72fcca58-848438d7340mr1643042b3a.78.1783496728540;
        Wed, 08 Jul 2026 00:45:28 -0700 (PDT)
Received: from honglab.tailc96cb.ts.net ([140.123.97.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b97bbesm6881521b3a.17.2026.07.08.00.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:45:28 -0700 (PDT)
From: "WEI-HONG, YE" <1234567weewee457@gmail.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	vkuznets@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	thuth@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hank20010209@gmail.com
Subject: Re: [PATCH] x86/kvm: Include linux/types.h in asm/kvm_para.h
Date: Wed,  8 Jul 2026 07:42:49 +0000
Message-ID: <20260708074249.157987-1-1234567weewee457@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ak1Dd5M6EtzOF1k_@google.com>
References: <20260505065849.81691-1-1234567weewee457@gmail.com> <ak1Dd5M6EtzOF1k_@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review and the suggested fix.

I checked the commit bf3647c44bc7 and agree that mtrr.c no longer needs
linux/kvm_para.h. I'll send a v2 that drops both the stale linux/kvm_para.h
include and the linux/types.h workaround from mtrr.c.

I'll add your Suggested-by tag in v2 unless you prefer otherwise.

Cheers,
Hong
