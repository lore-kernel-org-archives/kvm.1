Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A83E8C57
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334585; cv=none; b=qaQWSFd3R8hR+mkDUoZuEzTfBVHtXK/3JRvQzDfF/y+g4takWBLWBiuB1/AIsSRlxwxsUN5+8ipslN/9saCHPj63kj2mgb6axpwAmdnPbfYU88Bwojy+NYhAbsgLIEgksNZ2dJNhxaCall/s1g5WHhdYaYoyAiAxgw9b1VupGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334585; c=relaxed/simple;
	bh=yu3nC6vhpzZez3hZu5WSDBz9l+V7URi8BT2ABBFXuP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcaphvWjIrrg+yRaV1KNqsE9aDtjtQA6U8nDXwZoahixqyMidTtCfUyEdVSyqQaEqVU8XdVMDI7xol7Y9z35lCVCocOYZTiExBCyFol1DvF85O4JFFJPa377Tq4TCek4ZTxsT6vyPYc4az3trRj8fylZv3aoBiEbwvtX4vZ51+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgBSwq0X; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgBSwq0X"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fd27754bso7211895e9.3
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334572; x=1774939372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=BgBSwq0XGX55XxIPHkyReappFqNPHlYbS9wRox59BhY2ggelsZwG3qm3tAES+H8Wo6
         xUxtExLkAphLnNdwGId6ojdg6SNgtgBBoWu25lX0PL7BglUtngFLRhI/95DV+Dp8nYav
         Z1USzY0G8VLWMwimeg+bCFqrnrjOfYk99G9fxAxj9BqAF+lEuR/MRzxu6NXgpynfFwNm
         6X7KzIHSkh//xhBxNDrv1kroTDXtZUaMw3uhbGltsaCATeqsKT7VglrUHHUWpsi/vBAt
         QisqXy8QtY+5GTVDlCgt1n4pipKTAmbiCOXtOPi0V+8X3CDeK8CpNOVTc5Nsw5JmDM4S
         ZPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334572; x=1774939372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=muehbXaw+9Kbu4gdOpUZMjPQsWSNnS4F3uJowfMbSOK7QPAsFK6p6TAJ6KYAkADzSx
         epfAVOc8j9YvnsOhIS1WbXIQjczSWOO9OgsA6yLnDRXaD5xoiq6hc0zqY5Rpm5zB+uq6
         9jhmsk4LUnussdhzoUaitTehpkw7BPISHiUE6mcyG54wIM/ByBWbA4dlUR1KJrJUWC1y
         zderiLiJEcsLNPIjKr8OXgUz18E6qkTaUfjwguzU96qRimzH89hI1GvAhk56jEPPdkuq
         hM8W7IfIatXLvYjON7k71AeE6md4NyPtFTOntOOvQkKBOCxvvkpvQSLZbnDy4xaoAZ4b
         n0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkh5vqHIdKWhCGtuH1BF2A+Ym/VvUzinLay78nTP2s/jv+MYsbxz/rhmSO2En11QvuU0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy200OQOV3U69mpAnOT6uFbAtnF8CNy03+KVML5+DNfwjifHYBY
	qWPtam9FMIzeU34+iyYwGLSIIt9F4vJXzOOfaPKyf2P+2umn4TXoBTew
X-Gm-Gg: ATEYQzxmW44U8m1UonKjM5h6qmSFbVNRoxrWxr/UFnBZqzkVRatjiPiHx9QGJrR4Go8
	bYzvdyPfVf0KIXIIT0rBWHt7P5Rt41FmlRWdfQba63rdRnGviYAMI+x7M2MsWb2zBtu71b+9VM1
	qXWjqc0Y9V3F6OID0gKgvZlMxRg3qwIlUwVS56n+eUb2hWXFVWI4S2z1t8lB3UnT60JWuA+dfQP
	t1c0mpGQ8T6yw3JzCsw6VHDrQsAdi48Fq8ED9xnURxW1eQSzhN66fSghZdyjqcsdr8ocYynn4uu
	T2KmAiP8fTDQN1k++HvNyxvhi9sPKQfI3JIvV2C4hhmAP063TOHSt7Wwz1dVGvt5Nn258hrWBk3
	vVOEgKboLTkg+UUoPFX/bmOZyQc2AKfr2FoWHdmIRSLKQlqNSL1lANC8cbE0ZfsdQXDi2xqOP0H
	ciQ6KuGg3nrW3DXfKgOWo=
X-Received: by 2002:a05:600c:8b31:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486fee304c4mr210200845e9.29.1774334572299;
        Mon, 23 Mar 2026 23:42:52 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48711116cbfsm10881105e9.35.2026.03.23.23.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 23:42:50 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: dmatlack@google.com
Cc: kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/24] vfio/pci: Base Live Update support for VFIO device files
Date: Tue, 24 Mar 2026 09:42:47 +0300
Message-ID: <20260324064247.3271583-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please, remove me from CC list in future versions of this patchset

-- 
Askar Safin
