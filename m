Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634688;
	b=5Aqc5IJy//vjDQuy1uPSAr9aM/zZX+nCPuWYoNzMVaWvqUgYyjFSSeLdc09TMW2iMQbE
	 KFXONlRSqTgWOVccvdXRWfrG3IZ1TLHoifK6BPOAUN67PIdHad8KuPVLHLbdEFb+JwTLn
	 e84Wf2Q5bmGMYHhgKrUmtgXX6dGcMHWQCaOUSVBrnHu4MrCNJvKEDIwVZb8LN7m49otdm
	 B+e/M0bQZ9ncQLF8Y+i8ZoyTHbLZlDIejztKjeQj9Dys+3zq8M7DfWO9JbYXc5HLRjgXD
	 ZpdFWNgjk/JZk7q7hwcWJ+Ehlrcb5qIi+jKiWPt3Cv7KzP72yy0Mw8sG39siLgoxQng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=G29maGtmsp2d6vk52+6UC3L+iPYrlznjCdfPM1nxstw=;
	b=XjBaJK4aKGSat2Y8Kgm9v+GiGUv+BB+vWStPAnar9IRv9485iFvAqA4m51jtmWt3vXbk
	 HXrhei+41D7To20kDJJ9J2EaQm4dj3ScA9Qmf+NEs89t8+fVZEWDbmT0TvBDaO4jHnrB6
	 OA8i5Sk1c6e1AZoxrTTUem+laTHNEcUCtS+Lt3GAnk3NJvDWdJMvJVoii17ukevyId8oZ
	 dqa17QHCsSaw+ZLGON594usNTeAnPSzC+p5vuhf8514XsANnHTWMqci4lap910qqSY8is
	 i46FlWJA5r4B0M+dhCr8A5McZ0qes57QFV5T6XCzEPoZGI1RuN2lWl44Vkb3xfKeR+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BlXpEOYq;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A46606A6BD
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A46606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BlXpEOYq
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so3111806b3a.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795634688; x=1796239488; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G29maGtmsp2d6vk52+6UC3L+iPYrlznjCdfPM1nxstw=;
        b=BlXpEOYqTxSQUQ7SiQ8cN9LPID4TfDurCXPH7eLWWiLk8BTDB2H2snEueh2+VcZtSo
         W2qXiBXmRsU7MkDg1/74V2hbf8G+tCsbF5vUSEEH/EX/SrtPUm1TTJ7pwmV6M0eALvf7
         BXAJfoihY7eqxZpyZldSt7IIsme6pFeGa0Ld5LQYSkhUONcK44H4iMbBbFTceDuYr7O6
         7oaQ63O04vu/YTgCI7tY6L1Q3PU1sgUGRj/jBDndU/fSOl2dHcpmRg6y5UubqKRBF3n+
         1C+1wEAAAxwBoaVxCoNUioX+91eaiUeyAlF1/loSjWpswojycxFWj/1Z1XygAbylBCQ+
         W6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634688; x=1796239488;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G29maGtmsp2d6vk52+6UC3L+iPYrlznjCdfPM1nxstw=;
        b=Lf8Z8of2eH9597V9Vd8ni/AmfW4B7K1tZJkmf37q/ofY0hFUO77BnDxUUNSKu+XMS7
         jl0R811exAvLqravu2F9Vrkixf8gnbMtE+kB2/rY6hsme67I+dsk+XzYsAeUozW8BiCc
         nf8mxxBB+tmpIs07Nlc+7SBvgqBCRyYfWnqbdZqz0zFKl0WAKxynsUmQjzkm659pUueZ
         mI7tnO5ZvDWZi5Qn4MXLJ5rJ99B3MRV/A3BPmcqi5PCmksXJ87GeTM4LQIwMqIh/u9Qm
         8JTzv70LY7HW6fAjmB5M19s8QXlz+x0nOk8Ue3Z38QlihKcAUowlLYV6Ta9TPJ6Lz9T+
         GmeA==
X-Forwarded-Encrypted: i=1; AL+hErFTBDTh4AasbueAE4YfDp7kMWZjiVpUCHVlNShC7DcjquVbjCE883EE0ymyok22qwww0cw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L35UVm99snipMqShYDkZMbB0HR6QWh0N/oXbMeDAjE59MAoyp
	jPmAuWPLAKgK4JpgGZ4GByoi2NxiGqEEwfvZ+CKxdctgpsGaH/NZIvETUN162lrDmw==
X-Gm-Gg: AZFdTZcrpxLESTl2IpbMDkdfBFFR23nXo8ZaTWMu3o/PEEyF1pGJ5OmdfNozav3zr29
	4hZ2srBxTDhoTKzMwc4UKkSGI2caYvZxZVuE6aYtO0B4cu+lgxJdxQAePbB07c3q09EHhpq9ybs
	Mbr6S5F6TeVjbDDbIUIzZuxVMZx71691iyEDwtrpLf0FIcxivzfc6HTno4o0Xtr4gkJIoXogZjw
	20dBC2dlP77HRDnCAi2aDBVPvjTt3989fHnv+p4qzx620RvFAhuWrzGz5cDe432YqzjDtxeycNY
	u6LkWuO1q9oAkVBvp/pDkLuVOv2Li/1yK12j4/xRsDufvjfAy08cAelVT0cEztAieakhfPxetad
	LuQJao7k/bqn0UotJIB+pzd7o4KRE13MbvCWHbpiqT/BU1d94WQafoXsHCM6mWMwkbKlJygBSyZ
	2RmNJOPSuQZEqQWNCigBzNRbOii2pJmyYvCe7ksWm4EuuMFe55Bgk79yikyaz1hyEaIMrtUeMYa
	e2NC5ZR432JRu2K/i21sizjgfzdvP/EEnrKzR3GNcRpclXzefmYKq4mx5dVegOW4Tzd2iKwGiYi
	7XVlXTIyQfxg/in/+TCG+iGm2TcNQ0MDdFLap7RHtIa7TO+UIWpMHbAUiMCfRdPT
X-Received: by 2002:a05:6a00:b80c:b0:899:74d0:8a72 with SMTP id d2e1a72fcca58-8c87d90393dmr17708068b3a.59.1795634687045;
        Wed, 25 Nov 2026 11:24:47 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873f11da2sm9204175b3a.55.2026.11.25.11.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 11:24:46 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 11:24:45 -0800
Message-Id: <DN4JDERN99EE.2WKRR6CJ5R4OI@google.com>
Subject: Re: [PATCH v4 5/5] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
From: "David Matlack" <dmatlack@google.com>
To: <sashiko-reviews@lists.linux.dev>, "Aaron Lewis"
 <aaronlewis@google.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261114132200.113697-1-aaronlewis@google.com>
 <20261114132200.113697-6-aaronlewis@google.com>
 <sashiko-outbox-214571@kernel.org>
In-Reply-To: <sashiko-outbox-214571@kernel.org>

On Sat Nov 14, 2026 at 5:29 AM PST, sashiko-bot wrote:
> [Severity: Low]
> Will passing a non-power-of-2 size such as "-b 3G" abort the test inside
> iova_allocator_alloc()?
>
> parse_size() accepts any positive multiplier and both dma_map_unmap and
> dma_map_unmap_from_file only check IS_ALIGNED(size, page_size), but after
> populating the mapping they pass size directly to iova_allocator_alloc(),
> which requires a power of two:
>
> tools/testing/selftests/vfio/lib/iova_allocator.c:iova_allocator_alloc() =
{
> 	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> 	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n=
");
>     ...
> }

This is a false positive. iova_allocator_alloc() no longer requires a
power-of-2 size. As of commit 53e5fe5f28df ("vfio: selftests: Allow
drivers to specify required region size"), which landed in v7.4-rc1, it
rounds the size up to the next power of 2:

	VFIO_ASSERT_LE(size, rounddown_pow_of_two(SIZE_MAX),
		       "Invalid size arg, too large (%zu)\n", size);
	size =3D roundup_pow_of_two(size);

It looks like this review was done against an older base commit.
