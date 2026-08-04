Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E733EAEC
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817632; cv=none; b=rw81aq/l+9aZBajZgb/hA7VhHQ7WYlsN3Uj0mV9wIBj81Wfn52XnrcIRpJXo3bK4IXW/KJAkLIN8kpfIYneRuI2TTE/w2029aklWRquqvqRcxlcuojqJvBIe6ZeKnXKg3Qv6+JDPREsqkTCu6yG/bPM1TndPa1ZGFgmA6ElZ73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817632; c=relaxed/simple;
	bh=AU0X1WC4BZKI6COQ7N4mxIbffSje1Q0jlS/WBmyJ8DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EV/3dBZlWTh/mEOjvLvG7l4FFmhjgpcQ9yxmMaf5CUb9wkfwey0fi1LRud6WoW1uQvsTqyIxbt7MEg/TyiGOYvos5vvmwY/ZHiI9h3MNXc3JXHwBW1QJyjD1ji2zMj2T5hQU+fpMFyezqhteBVPoErLIPbhmOj6j/Cym6Ta6ytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfaBhFTp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfaBhFTp"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487214ad2bso5817130b3a.1
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 21:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817630; x=1786422430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AU0X1WC4BZKI6COQ7N4mxIbffSje1Q0jlS/WBmyJ8DU=;
        b=OfaBhFTp7FyTnfTUI1JOiFnK0Fp/3BPiGac7umCqFOIQ49DLQcvdaH0YUXU2/z4m2G
         dCuVnrXhy3tdWM2IimP5ZbrbIEDLufZHCsU0xsuogV3kmtoy6JWV2NVOZRHvkYe+MjDu
         F/Oe+2kgR4bk1y9gVoNJLx0eXDEUVJnxD4ak1qOU8ge5Ay0tS16KdZVfzzVt46sBDx8b
         chDaDFuaHGRiBZF0vD2KDA/dmQ8ANIbQ5ButPA7cze//RNVXESLOSuWPM1RIVbpc1Un8
         FWOvNQiHrN3iwYwqjIOHppxZT/QPdmXG5+O8D3LU2CWhwNOhzY5oqHn5ba9c+wZJU7fF
         yOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817630; x=1786422430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AU0X1WC4BZKI6COQ7N4mxIbffSje1Q0jlS/WBmyJ8DU=;
        b=K0/MiUpXTs3pcnABjFYeEIaB6/z5+WXRLZ6/4xsfabSfUYrfxakxNUpfjfgT9XRko+
         nFQNrxqcKoFvkyRckvzfRww0u697HWFiwWAA3toatDma1Ce5O+iMwQbZmqEdy2X4D/Y/
         e37N+Cm4H3R4OYDA9hsU4QOlT8k7G9C9sAq9kvqc2KiV4g1W23w61os7kR3f29qoBAYI
         LsM0NOwEYqWmUvvWwgenvP8SkBseGIsTzaN4BtqQFLMXNhyhgDXcKTyU1EVl4na5sRmL
         HN+HUA/VX8Kys+XcINTcHSUEp9BEOZeWX0LHOFMFXlbl0/r+7+V1SW7+dVU5wAP8+/Yf
         p5TA==
X-Forwarded-Encrypted: i=1; AHgh+RqaEEVHYLfpX6SX3qCb4/k9QohHhGtyxYR2rrTr0D+mPrVlEUDNnPL6DSufed2+m6ufHlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIeVsdmEvBnclueZwDAxR3ijxUphWAm+AoC5tP0xJFoLzhCUi
	rmDyL/ZAAMI0Egwkga2hG5slZBvpdHokfDxqX3mPPCYNnHj8rlud9Tx2
X-Gm-Gg: AR+sD106mD0cQoSou9l0Dhh+WFPALtqT8E4TYTlTBq5NY7du6gSCD2OUqwdfR1SUSsH
	ZBOKoI1i2TWB+RMV8eAb6vvHw+yBikAuMCzV7K9AnXMSTipCacnx+Hosk4XEIG9M9cbk6xcYwS+
	mmFyHb84k3cjI+4jzTFi3yuL6U/3lzOIqtxcZF6sdrz78Z+yxuadRgdmXFBTrIuwz3+h4ELSYi6
	WdKRSNJcKdIdZm539ta8w2JdSnEsuUQypqc3lKXOLlmAwq7CnhOCUH7J6dqtY4CWG1VgmwqCZNz
	q/AJXzSvJ+frzBtUqWAV2YIhZ5dnXpoTCvv64OirCTpP0rw7qNHv5juaA66MHc/Fx++F9slHw2s
	RjW6Maz5WyAqwB1Q+Sy3dbC4bTDvKiOswA5q4YjNT8FMIGxHPaoszyt4Hfjb6wmts2lx2nMIca5
	L8B7jNKphbUt2v8nalwrnSXV4xA79RMCDxrQ6pqZeVYMRwR+yX+WUxysL8Wb0QiRI=
X-Received: by 2002:a05:6a00:429a:b0:848:6895:b754 with SMTP id d2e1a72fcca58-84ee482bf19mr11805742b3a.28.1785817629562;
        Mon, 03 Aug 2026 21:27:09 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc41ca4dsm4510051b3a.52.2026.08.03.21.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:27:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Tue,  4 Aug 2026 12:26:53 +0800
Message-Id: <20260804042653.6014-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803232008-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-3-physicalmtea@gmail.com>
 <20260803232008-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:20:48PM -0400, Michael S. Tsirkin wrote:
> You did not CCc all maintainers and lists with this patchset.
> ./scripts/get_maintainer.pl -f drivers/vhost/vsock.c
> will help find out whom to copy.

Sorry, I overlooked that. I will add the missing maintainers and lists in
the next revision. Thanks for the reminder.
