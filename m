Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF1189F43
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681896; cv=none; b=R8x83qP3sh7Ue2cRVuudIjtnuqK3ETjMzFRwvbof8uaWThClK6s6eH04UZ9PfOhLnAHzxoOPDAwUsXTt25tI7RJ2Iik4q9++ubVWXgGsPTZq9DKMbpZO2rzpQ7FU7WOfRevYmGx+Kdrm9R4FDcfucxTLB5VPlSeqY69Rlpor39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681896; c=relaxed/simple;
	bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoT6QX0aNZMlwJUJbMz2zvsrEawoXu5rA3Wu5kUNxQ5qEpeYg7OQzN41wo3EOQdWcuXEm7lM5SFj3Cvb+myxezWaDZl7npaQtxT391+8JMqRzpv3Iu3i3+dVynAb2jJ1GURHnk5tq8mJFaMupEpY+qyRBn/R1DPK033jwL+oiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVsh6BYu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVsh6BYu"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e7391839cso530420a12.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 21:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681894; x=1787286694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
        b=HVsh6BYusvxxr6KiwoulZbhma1smZpPjV/2j0kU6mle8rSe4HR43IYiwHB57+v18K+
         2leoaDP4nOaLOclAAB0Ssosb5A1kc1G/2DhEk8Dvukja2zeOGQENRfAFWZh0zr/zlgZE
         iJkefA00cfykwokspMuPnZ58XwV3VXqb18otGeK7BtFYlr22j7ZaqhVfrh1CkbFrbq43
         nfACF+cbE8UclOHjXfc5UJ/c8CI49DIr+p2a0XTU1oBLk5RQMJOGYQVMXhdQvo3H/tr8
         hxtMZKu5sHCkpLXGxB8kz9dE9eX21jdZsGhG582mVomWxjzcduVVdz2XwMcYOb51Wg3A
         kNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681894; x=1787286694;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
        b=NZtTgDXBOMqm00nw4ZSvzQaVl5rvpPyVTn8rNoISqOpbxc/FsJXK2MX/4uqUoBYX2E
         6dkt0S7oKl9VKuvPdY9J3+yIxlYGhTnhT+7L9udwIXdQeOVVw0GjQcZmlBedpvtkGWzo
         pZWM1QCt/D0nV0sAQ8hfkwXMJTt4ah6uFvpOOlzulUhSVnmuHxDbdAp5zgYA3FrX8s1M
         ZPvkJzFUlqWWrLXKn9+7+BIUMVH+PQiWLKSYiC4+eWWgBuCV8nn59lzFgJwgUxuAy/ZV
         5duarhoMsNX6afS0dYtLdzdhbR1MJ6wjDBRpww0WDZOd6IMpiEjccfSwwUs7UIRku3VT
         Y8YQ==
X-Forwarded-Encrypted: i=1; AHgh+RppOnoG4zJ/gqrvfsogYgIA29H5ZNe2j4rKqZNbQMxk9FMVxMiHRwe6+r1Q2k80k+g/Mnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbCRcqnz0Y52cj5LBhuF5DsByyP3PlEaPC1hrZXZhJJMqQKF6
	OIh7E2VlBUqgjlf+yPzHm1D64+998gI6+3YT4LeXbnJ2T2YbPrAeunBd
X-Gm-Gg: AR+sD102QUB6ikJFBerc3SGn4kUw49bpVCyF4Yw9XNus+JEvaYC8dhzq4qZ4IqCBH3H
	6l6KJIGxpejmro/mNus+MDokOFu2LwMHVgG6NlFln8u1/c3vrpB7huPxil7++OVtV2nxiZ9rUuE
	u24KY6b2Rt1EtuNSwgIQjQH2V+Q3y9CGQFKRGKDZwUiuqwJTKIQ429TU0PKi+qizeAIda0xPt/N
	KoTLTUnX/6O+qZvBQlZwmLSnmkqEYhcUkeOfkLuwhQhSFwisNPzdE5Wbgbnko+AblB48+vCMxE+
	t9fJsfC4QWJZpc/CWK/UfB+F6nhHp3IlGngPl7oP+I8NrktGbH2bl6sV01rpnHHvw+pNOXS5Jki
	0pteLpnIsqrbVJ90vXAplG2KTDDfg6g1Aalwkfut8mQElYwK3wjrwG9BunA3/mecaEdU7qBU3XH
	cOHUvHUSB4nK52OvSp3RG/lvDa+M6tGYNq0Ktl6NZ1zk6FIusPTE0LrxqtEbpAdYs=
X-Received: by 2002:a05:6a20:4321:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3cc71a2974cmr3124821637.10.1786681893513;
        Thu, 13 Aug 2026 21:31:33 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889d914sm4450683c88.13.2026.08.13.21.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:33 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: stefanha@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 12:31:21 +0800
Message-Id: <20260814043121.59610-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <an2RzeZ2zI8mWFRM@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-3-physicalmtea@gmail.com>
 <an2RzeZ2zI8mWFRM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Do we need a Fixes tag here?

I overlooked the Fixes tag. Thanks for pointing that out. I will add:

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")

> Do we need to do the same in vhost-net too?

Yes, vhost-net has the same IOTLB lifecycle issue. I previously posted a
separate patch for vhost-net:

https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/

I will update that patch in the next version to use the common IOTLB
teardown handling for the ACCESS_PLATFORM transition, while retaining
the vhost-net-specific checks for IN_ORDER and other unsafe feature
changes.

Thanks,
Jia
