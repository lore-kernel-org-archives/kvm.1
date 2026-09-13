Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F261DB13A
	for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789318057; cv=none; b=tjVEit8XKXP1cs96z/8rTfQuNmgj0xyF+KYXT5EQqu02zfKMQK5LZJrfaZ+N72CM0awSthF8m+wG7DiNLlGJHDwv1jYHGI7nuarnil4A6tDxo5aUQvKNKH1e7pu81mjRuOAwgH9MytuEG3XaZ6vmo8cs61tQ6jeh/bL+o32SHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789318057; c=relaxed/simple;
	bh=nXTo+6gd1th9Mextb0F9rN7xBD7Ie/Sv9oVlvhCSGDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9E3AaojApx2w9I9qJy3uM5U1qBFBQixy6Huf+gmFrsriovW0ymf8Ud33gaNdyjOqoHHVKb/VY8LIjTtbhYYFOgd1tGzrz1BkmLC8Hdws2iPOy3mGcqQKVXj7LeBUwEwkGlVR5vq1e4aOBfj8aivpPm7t6eeoDH3Pvr7c2pCVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rL9/a8En; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL9/a8En"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6af07e08so603965e9.1
        for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789318054; x=1789922854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nXTo+6gd1th9Mextb0F9rN7xBD7Ie/Sv9oVlvhCSGDk=;
        b=rL9/a8EnZB/QyMK8uEr1CXB5mZ1+aEgiX+zsUbvqFYgfyFrsP0TnjtOgkC2GxlHFuK
         f0BNV5O6gORPMsP0Ct0e4ZMTWnDZfSUZui7hVfi8KhHiRsTAIQabebFlboGqJjrsI/UQ
         2/lLxYZSVogtT/aWXZ0PXEFWNHmX59cYE1JuvcONUcUNhN4Ys1AHfckzJUqV8a8TYi8K
         RQcrSIRPZi72sRsytyuqwiDFmJ3G3yOQf2EPQJONylVq+fDcQH1WjNHf+0KyHum2BwtV
         cfwFJdRXOpKpxrldnMZD6il8y69KsNwfs4/P8RILxvNV51/ii17aKvLdgM1c+tnjT+Ww
         Rwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789318054; x=1789922854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nXTo+6gd1th9Mextb0F9rN7xBD7Ie/Sv9oVlvhCSGDk=;
        b=NIll8GXcBhvAkPuWrpKyaoDYAdQWkchjrpnP13KSIN5S3Y5pDYplq7xf6kCL2Bw322
         qO/a+vKnY5dBU7PgOFfRNmVJKSb/Qoo+8mifXrI83oGV90yVpsVjiDSSypTklBDuy3eE
         oij/E2P4xWoAdaCavEXy2CcXGeu7rpQ3O3/HpAdGN4Wd+grFSDr6Vz7ssYyW+v0JrxMb
         5nkaVQ2MOzzWr9z15L2/xTk3X+OHpcR6l7aEP5xbb0JprbKxK0w9jayA/KfauX0lAQ+D
         ReUaYkACvcLHDcYv1mPKgIsyl+a04qI0cRnP7+kNM0mhYrRmu/rzSWhGaUfoR+TOcaQP
         OnSw==
X-Forwarded-Encrypted: i=1; AKwUvBw/KpizLx3IFEuNidVNFDB1IdZf0crIpLbkdZLWXA69o4381J4yJlASJZ5CGWkxBBww/cM=@vger.kernel.org
X-Gm-Message-State: AFuF++meAn697F3wNhArPqVm0WxFOzi9S+nxSrMNpvcDbpDlWG+/ik/y
	j1QUYKC8DfaKgWP3mPZh6Pn6IHro3VxgxpRI3Ye2WArvJVxejwpiQ1EbVOAiz35l
X-Gm-Gg: AYBFou2IVR1hb+KCIgklAKXddrLGExKJZdFM2qmb1dOsfyDz+mC94C0vOzG/2OxlnsI
	pAqfWTWnnCez6t51YJjaOkslW15sSSf+neaN1Tm7q7b0u1PPxzrjmA2PBUHEPttSEbqF/TVpZv9
	MdaP3in0KnHWGfmxGud5F079i+31HVpCLLeJOec5SpsM6iTskz60NSxRpK0UpFtRWV02MOK2PoN
	waIWrxd8S4aFaWZ5RRqxrEa8jXlDnYhaVcqL33qXnK90Wd2sQBPabxDacuLD6tIedGwHgQFQ1RY
	sKjMkrOB/zuKydVRrrgFMMrPvIiLS1PgQT3Tp7ZeJmJ0cBVrl00ZVVoMPEFoMne2Z46kjVUzLY6
	YIlxUP2yUpPu0LtqGMcOOo2AfVQR0SDEt7D/+IFsRlg+dk80SBT34hjat49w9DRilEQKecPuJfQ
	bKYpfr5H0mPH2iA1OHALhCukAQi4Nt5nnszg77V0W80T4veokBQVutFdFh5WmsLgGmohFthDf4h
	Q7ir5yG88vXr3SJo5KC
X-Received: by 2002:a05:600c:8b71:b0:49c:ff81:e062 with SMTP id 5b1f17b1804b1-49e619d6a4emr128653125e9.2.1789318054195;
        Sun, 13 Sep 2026 09:47:34 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm369652055e9.14.2026.09.13.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 09:47:33 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: kayracizmeci@gmail.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 2/2] KVM: x86: Add limit check to IDT in __emulate_int_real()
Date: Sun, 13 Sep 2026 19:47:28 +0300
Message-ID: <20260913164729.1273645-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824084523.406940-1-kayracizmeci@gmail.com>
References: <20260824084523.406940-1-kayracizmeci@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle Ping, :-)
