Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57004071E9
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290750; cv=none; b=X2A5n9BCtfbFPE+rx/g5jAiyWjo0kQGZuQqOL+WK9zeS8am2JZ5ru9zSuTAVTZEQrJH8CQy3tWnxiPiXUB3OgBCRWdab/Sag54hki8t6lUd3DJ4airpfe/YVnyqboAwMTKRy/QPmxCokF44dHRL+K4Rqi8abaec1ERZ0ONfWkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290750; c=relaxed/simple;
	bh=SY/Dah/zPU60yX+nRvB9MxhPWEeufU0az5LJrtnHOBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLNeNYxxDuqn/w7IJDLbI2eWjvoSVH8A6siVgI8wnqLwtGOlajzZwOWHzNa+L64pU63Fk86uOV7Rg6omZ2PYa8+pFbWvbfXQGy9oDv4gvkpXgoWnw0I64ThbipclxXnZq1QBmp5SaHakoGc8/f2jJ/rYvNsSRPCvt/YL66OgBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+b5ns36; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+b5ns36"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ced3386430so6195325ad.1
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 22:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787290748; x=1787895548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SY/Dah/zPU60yX+nRvB9MxhPWEeufU0az5LJrtnHOBs=;
        b=h+b5ns36evMtx3bzknDRV867KsCgfFWIK6nr8+64cJNmxOxDfHop9CH3OtG/1acAbt
         YKt6yItiUeOqn+nK0Q/WiB7p8FtZTfGyTyay4R8QBr+wS29YrCWEIRC7qtkqOTtgAFz1
         p1uuUpjQ/fZ/WIQdjrOrqtllWXNHnTwcAKqeeWHKcvM9sG/81QRxsbVftObhsKJz+poP
         qoKg6+ceesHRNCOAlqjO2R3mwmY/433A/A8eaKGMD9QpnKgUP8tjkwTx+jt+tVVQspfR
         C8mn6tiDJj+jmaOylANISSXsVNduYkx5cKWC68MTrc19B6X9LJLxxPmIKdjylb4E9nxf
         lgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787290748; x=1787895548;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SY/Dah/zPU60yX+nRvB9MxhPWEeufU0az5LJrtnHOBs=;
        b=UYLNt4k2uM2eMVi3hEHnncnMdhY1x+gCgw0Vc+0uGG/ZIc4eGsQ8WGqxEVEFQCZixn
         WktBh0xvCXQ9/3H4+aw950ToTlO2boMtt7dXvX7qcDVF/UxIWefuYUhQitDbwuoze6Yc
         bq3RChtrUOkXv9Epeu6W3kdrs9SqDcybWT7rOkmO/K/MXAr7ob/ou+RaafKR02uldRGw
         zKqChT3lrcOxsGgvc+HzOznjOx61Le/pDQFsK1GI6nOt7iRKNLtccuqrc1o6NaYCTgjV
         HuXtRlS07N5fRoqMkfJl10bugGohoe6d3gIEat6gNJEUwwsqL2Pwvud+3YWNFc4Sguv2
         dM2g==
X-Gm-Message-State: AFuF++kc0u48v0U4C4ImciJxfYZom3jCh+8hQen4WZLMVMg+vPRxFImX
	AeyHOlIwz3wOT7fhKt2JF8YEWMU7gK226+7Qsa1h5fWKbFdImy/sa/uJ2XvfrkES
X-Gm-Gg: AR+sD10v3yVFHzr/pNOben/FnUdrUlePBBQhKJs5EjLPnM/4Q46bOU6HGBMj75rAELO
	WVZHRjc1K3nqsGTLWOhOPfqLZhBF2ILgjrY2nD64tJFwpngrYuWz11MPJrBkI2sP25iBgLiEzU/
	IXJPcVbb2HptHft7gcWND9GiCmC9RGurRdfT+X6IYTViTE12QM1U6r6buvSh8BnO1/ONOxQRh+i
	RIrC1FXIYv+GrRCi8vO7T4KPC/5i8K5HMWQSZp6iPeL4ZIifEnccs0EUMtxNvhGwgQiklQR0ETK
	XI1GaJe9/KzuPlRoJBDB/uNBgAMb5rBaj/KW5D/d6GGO4s3UkLndVTtp5cl7Z7g5p42uPXUFiQo
	nydTjZViefAYvisgyT8eT7S9cQT9HeYl4mzhgWZ9TD2jjhY7eEZDaqbDG6uXt74th9dyt9hgmn2
	81pBQ1cv/AYYLWfgrZTwPO+s97WUYGi8HxLErK36B0XArZiAd+SA3qzWd9xo5Vr/zwf6GXTjgHT
	SRPO2XnMtGo
X-Received: by 2002:a17:903:19cd:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d64affe4b4mr81817655ad.8.1787290748155;
        Thu, 20 Aug 2026 22:39:08 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef7a0easm26708338eec.12.2026.08.20.22.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:39:07 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] KVM: selftests: Fix the bounds of the SEV debug dst buffer check
Date: Fri, 21 Aug 2026 11:08:08 +0530
Message-ID: <20260821053808.1216172@gmail.com>
In-Reply-To: <20260808061934.400892-1-gokul02k@gmail.com>
References: <20260808061934.400892-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: reply.sh

Gentle ping.

This one is independent of the other two selftests patches I have in flight,
so it can be applied or dropped on its own.

Happy to respin if anything needs changing.

