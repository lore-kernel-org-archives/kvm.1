Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DD36B93D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 05:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787720671; cv=none; b=sU4BWj5QjR/v5/8k3TPOXTycf3k6xVRyBSW6f/cPn7uRn5q9yKN0tad6NxsEFY/3N28B/Om3yhEASybIuORC2sR62n4VA2RKSFI4J23dnQhl9z3p93wzLur4JnV3FG3HYA9Y62ByMZt4or6/xMF7IoSmSwuo9W7/uJrx9VLRU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787720671; c=relaxed/simple;
	bh=rvaXmdHMmazdIGdj9z6pAUEbbACnQf+fE97k972YqEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyjA2/yT8azVNS/engGtX3gaU2Nc22eMn1euqsTIzomDAS9l07I8+8UiTA5RxEukiePSGFOZIC+WMgT5jF9vDEZ7lliRpYJWZwgvaOiv9auuuxsB8oNR7U+zQ6aXPzRaPv5MKntelqY0GlrnHVXQRhhenoRtndIEv1Rxq096Cmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrSWjBIy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrSWjBIy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc891373e0so7772075ad.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787720670; x=1788325470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYv02gmUGksQgXi/r1LBaBHVUhBN+GFoofiyVDib5Ko=;
        b=SrSWjBIy5h4L5Jkm8ypZnEPVFvqCsHuAiqdqUekhTK/bOMLNZ88HhhRysV0FDz9KPT
         jlY+X6N1I3Lwh7HuwA/Rz5LwYj/82K9aIhcpb+ij8H5DGNndP1ERkjgLg/6HStY5HcuS
         GqtcXn+cPHmZ30wpySYxZhQ82TO2AuvCYs0n1Wqr1aTHCKcyrJA/445o++lIj90PsVLQ
         4LIQHkg6keHFi15sBPaE9iUNV6BshLLXrOMM33REv5HQB1uncRXdUsKViwPvvsZLTPfs
         eVTecGwSTld9HkEyvSxF72/G/Ec8V867ZhQY4FkrjG9VE2skD93cy2me+2PJwc1nj+Y2
         cZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787720670; x=1788325470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYv02gmUGksQgXi/r1LBaBHVUhBN+GFoofiyVDib5Ko=;
        b=LBpJauBrHDKUut+3bgT2INQrYPGYQ6zl0u6bVyi4fHrTwh+mqmtV7d+TYHJvokp98W
         F+OaGugIjGD6eZutFNAyFFDFzQGukBAfrSvmf6jW5y9jShj+S2Dk9PTJSG3R1hRVLAzs
         o8GAxojiYgcAxWOsS35F7h2dnPonUCpAoEShXBcOrIYSJvCU3T1bHfFikj+THD4jfdDG
         AyzQ/w+3p39wb2ZrG0RVvoAPtEQmWLez+SMs4WNDBlHQiFxZcxQGDRmpKCoUargD4qec
         oNpqVH1Ax9D2R5wBnhw3IGYr2zdpz1iKptZ70IwKAzHjJXn+sp2dmIxDwa4mZ1Pd2QxD
         OZIw==
X-Gm-Message-State: AFuF++ncejKl1DLEeE4nr1HLpZ9NsDEuUzLSyLwUEyqy4fbA5YP4ZE5l
	//ukvklVtWBrv1uEislQG4MeEnTLcGyVrqK6rsAPCBf5b+7tmcy62NAq
X-Gm-Gg: AR+sD11IFxT1pFeO923GHJKqMp4U4OAjuXxhdxlQNmaE3MuwClMh7/IWiBwYahQqeAj
	+hD4Aq+DubaPNGc8ewNIrXql1CBp0Pwu1zYia56V0ON/v/fxs54bs0XJWbFxY2PR8cwGzP7SJyH
	SwyZ/ZTe8u3sOdqMW7KHd4yVYdJUEdFm6LopW4yRQb91wYsHs/JbortN8Mgy02YirdJ4ZQD9mPp
	WSpdAei5IXhXU+B/WbITkp7trVcLbG5W9lm3XyqKrzmVuP8qzq2GPkqGIdr9Et4MvPpNkL0p3bo
	rB4RXwHs9Yq2loqhDcGa5jXsO/s2Rvwjn9v6vE9Mpsr8mOvkcRMtKZBZcSE+5McLcGTUEGuaGgt
	+4tz0Tw2y0pl7mXa+RH3HE2SZfBrB1fwlf4l3rkzXXITOJ/gPrZ16wzaz6vL3zVUQw0+eOmlGze
	CNgdkucSmgzk6MYQ0lCxK629Z3qeb3VRFZ1JO3rMcIEj7fVGqZXWBL6j6g8DrFj6mmHb8EZd1/u
	pCr/CxlTHRW1mc7z4egYQ==
X-Received: by 2002:a17:903:2341:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d707c1020emr60536615ad.14.1787720669824;
        Tue, 25 Aug 2026 22:04:29 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283da25c09sm6844956eec.31.2026.08.25.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 22:04:29 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] KVM: selftests: SEV: Sanity check the launch measurement
Date: Wed, 26 Aug 2026 10:34:06 +0530
Message-ID: <20260826050406.2836603-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811040858.1984593-2-hemanth.selam@gmail.com>
References: <20260811040858.1984593-1-hemanth.selam@gmail.com> <20260811040858.1984593-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping on this one, no rush - I realise this landed in the quiet part
of the cycle.

The TODO it addresses is still present in sev_smoke_test.c:

  /* TODO: Validate the measurement is as expected. */

and the patch still applies cleanly to kvm-x86/next.

Happy to rebase or rework it if you would rather see it done differently,
and equally happy to drop it if you decided against this approach.

Thanks,
Hemanth
