Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4F195811
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664767; cv=none; b=iFV98RH2FqcuyO4Be8Pl2Jo3jW+hFbNS3RhmL+mWTiNz4cCsRBE9/zmjtp5LYRd//zJU2tsrk0gMiIX2QmrUfvlg2djKtAG2W3JxU1tNEcB6xc0YYg+9WFKjag1MVWEqwlXIph9v0bWMrAS2eyILWxOAf0xRRWwj34eFebB3dZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664767; c=relaxed/simple;
	bh=bDzunumwdaEDbL9YFHjQCaqd/gR7WBp6xWWHCMKCiE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCXvTQQxl3SfgYDiP+5AbvM3erhXGubt1gYSDZMtg68mFZTCVlIR/gAdpEQXR1rzdQi/u7Bxr5GEcViXLTvc6ffFx1mzc9q6uuOhkF/6AC9/rPobPWEJ/9vDBRHHsFGFqys2KIFIciVOJmpFPGdOYTxOBAf9arvnNFkTu4PC6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLl9UJCU; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLl9UJCU"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f68f3b075fso9086251eec.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778664766; x=1779269566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksbN9KOmOoFN0rrlRsCA0zznOoGYAI7N/KF0NchvwNQ=;
        b=FLl9UJCUHlxfMdRxmuQhTUDkKgZn9sy+WdFT+pFXK3CKEEAFSHprIDzcJ9Gme3ocRb
         +7HV/OLBVJfA0Kg+Z3hV5aof+akMpl3pcZyfwjAr1lk7nBMHg7CVO2PY/8VDS9RluiZS
         kL0DT+bN7MfOMpQu0WMkrhlmt2nNQo2qKn2atIqFb4kpooT3jYrnm5vnWtPAsr89Gs9l
         F9+PVHYF8oV43rAfkOE+t9RnoSrB5Qr4G8PZVrXIz2FKvSjiOu1bFbh2J/rtJEzXMSor
         AST89yxyrapdmLPCmw9sJJRl7zMERuXOdA8zJDH/kD9nvbPJqVQHHV0BuG55QisHJbpk
         P9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778664766; x=1779269566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksbN9KOmOoFN0rrlRsCA0zznOoGYAI7N/KF0NchvwNQ=;
        b=DuNLfUCdxWewTkPHVNQ0hxok/oig3B2AQNSMDJT5GcRHQac7HCMK7Wgir2wj7Q7+AK
         FUF4SCRfd6++txMpalVBl+F2OouNXQzKwPU1hbnEWIIQVwZzTFyyZZ38Sk8uZhX+Dgmj
         FQB3Q8D5PAcCIQIvBP4QTHmHqfwLyg/o2NfxVVbFACM3m7go5EVS1cizdKllcL7Qn4Iw
         3IoksyDk9deEFKB/LLm+Ha4H8V/1p+v/PJH5DmSIQ33wFhfc+FmFKrh6rrQUIb4JLBeJ
         w3PneMI3kQTLu0mlYZmYUJ2TemY+RCr2sBYZ00ucK9X8ONVqodvB+mcNieJdDM3N8pod
         2qGg==
X-Forwarded-Encrypted: i=1; AFNElJ80i9PCQUbqzHBAucTYxcEeIqHzYJZ1DJzZITV+RFVXA/mjX5a91Hd51O29pHzo1C76Xv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYx4aXDFh4Rv7cl7vNk07PchM+O75Le1cq/XLQhhmGXjC6E5N
	+22BIRxK62htG97nm81P5hWiT9bI1q7JpjQoW9sew4iD76C594hgcthI
X-Gm-Gg: Acq92OHILEepWVyDlh70TqpE5t6/HwAts8SDILtvRlmxvvj9ddGryrAhCWbvTytARpA
	Q6NRGul1EKuhuTFYDOeKhVTAzsbURTTQvKC3/Vi3wkj1+/u8gHgRMwXj/38kud60AbNyjs6v06a
	GsBM2ZyzTl2grFdizvBRhE0E9VOdzFyBJFEIv5lkJ0+hG0UJyDEUqQCrmutgUWkERG3SN6bwQa8
	FmGjqTyvZURek4pSkR3cuxTE+kMRA9zPR7l3T4e5G2eV5/2Yzv1ImznrblNIBdzk/fDU1Pkb3F3
	tZ099P5OzmNjZrgba3RQDmR815Sm5shlD/7XjKJ5eLJaes0Tcva6vQdeA0Yfv32JKgmAS9BzEsi
	DOFWkYZaiYLEVdDduROSxypDihR4+R/znK/aQ6UX8GoURBa30yl6jybd5PAWDzppiOqnvnoBjb7
	mzxSdIXfbgEVzznxQogxnv1E9rKm7UwAGjUItN4TEg
X-Received: by 2002:a05:7300:7496:b0:2dd:405f:89b3 with SMTP id 5a478bee46e88-3011436b0eemr1731044eec.0.1778664765608;
        Wed, 13 May 2026 02:32:45 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm25646045eec.10.2026.05.13.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:32:45 -0700 (PDT)
From: Ewan Hai <ewandevelop@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: Re: [PATCH 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Date: Wed, 13 May 2026 17:32:39 +0800
Message-Id: <20260513093239.1608027-1-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513083042.1603237-1-ewanhai-oc@zhaoxin.com>
References: <20260513083042.1603237-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies for the noise. The previous posting at

  https://lore.kernel.org/all/20260513083042.1603237-1-ewanhai-oc@zhaoxin.com/

was sent through our corporate SMTP relay, which appended a legal
disclaimer footer and corrupted the patch encoding, leaving the series
effectively unreviewable.

Please disregard the original submission. I will resend a clean copy from
a different SMTP path shortly in a fresh thread.

Thanks for your patience.

Ewan
