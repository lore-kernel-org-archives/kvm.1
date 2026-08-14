Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FAE189F43
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708598; cv=none; b=QaVAR5s7QXmffqBZ5LsU9HxNicEcMv2wmrw+gTMAnEkF9cbOBiJpHJiWqtosRAM6aGvW0jsF9XZcsJgZYatYvWwUjC5Rb070RyidYoRGbI4P8NJWhtB4n9REG2IxMxO4SDZRKIsQNYkSjpwxhxZciH46WO9N+llBH6NlPMnxLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708598; c=relaxed/simple;
	bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrfE7oAuzJiRkN/9LAXNF4mdBenGshJ7yhiH2Ve2MvyQJdJQwgnlOL9pZ3WHNllt1X2HRfZxi6jSFVc0cXMXMLafWJ2sgzc+NR7IG/M66/QOhSDc0wbKHWdb6zI76zX8kQY78GknvLQM20uiOxn2PqJiwZcQ9S0EbKw57AmYa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ8Azt9x; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ8Azt9x"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485ef63b68so822221b3a.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708596; x=1787313396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
        b=aZ8Azt9xgJWTsyBCwf8wtIdNlz9N8bCTzOHqabPya9kRe39gCqyd2xPM0BIdAUxtoA
         BHutru/Rj+jVDgDiaP2TxjvvSPiE4tR2RBJ0OnzIrtksC4P5x0r8iI/sMDfAUkt07dlt
         ueOv7QEFt9K6byU0zbFOVmx3LfoBibGs13oi5JYAGXq+IvK5iV+xA5OIGfLLvd/xYB4W
         +WZ0Lc9TlfCxRIikm1D1OIvPtDSKOfMQ9NteIZbbV9HbdWRS0mvxkTD8G+CKVxryky10
         yM7zadSsNwz9DMMr1Kxd0WyM7NfcjcCaysLSkLhjKQ4ry9K2t0LZPEqdRAJhERCP6vXD
         Bm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708596; x=1787313396;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
        b=lOGT1x121yfABEuLjJuk+JRq8cqyuanCYxfzlu1hpGIVFjcn25TrS53BhvLgCGAbbO
         iMofA+8hjcQuSxCmN9fDSCHtbA2l31XuZQmG9F/PV2AhRgbIGL1D10tL0iN8qqWOQRNr
         TG+fC+soiat2u1EN+xMha61kw153FtlYm/+anvZdRuFCpMDM4BPa5aYCmQp4hVUKhFkP
         BZ4NxIrj59B/Gs57qF6HalbPK3q/WZ3V1CAYIwWiezM+YzoFdKxuABgBanqlp+Z2kitV
         UFIqwA9e7dcgWwEM5vv59tS7vZNZoSh5RcLK3PRNg74FWRormaJYUqZe3+l2cbndXbLP
         AXKg==
X-Forwarded-Encrypted: i=1; AHgh+Rq62efSqteHuJg5SLTVzzdT5z2eSeRS5Y3DNwbBLcFO179UOXilLGdnsQw009VTZG/h4GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgmkeMa9WW+IQqyXiOQS8q6eAvygBAJVwU5h4xHZOUAOQ27Ra
	U8r8nWWtmbm08TPgM/02sXNWA8J6idrC/PfNscDwta+wWdlm6Bn7a5co
X-Gm-Gg: AR+sD10jcwvX2SV8+dnLWqxAJ7qy79SHVgRZBLYsLyxbHYIMhvoosZsrmQsmatIefgd
	4gsystO2hLxXyM8oiQHmFQpxqheG74hoKrUK8JcsU9LKTgGbWBm43C1DYRnMuxAPwxwxxN9ZfSm
	IhoueLwcrLDHwSQR/f2a5SUuePjwQZ+GXuKQzdUYF1NTw8+hWcZh0pSphcxrlFEC+SSgMyYWekI
	0uvjY1IS5smEB3UT5pjhYae3k8f16OIVMzwn8I5QjKA6SvZvwVSw9p81fG5SUhMUA1lueFYe93C
	oWgJ3+UMi90IU8bFwoFEEc3XgYvUH8dcPEv53SKPDVmd0mFAbUA6Nkma5a0bZDmf17QkLIFC/6D
	PWKWzBh/tWZY2Aw1ebkBnlVgnVVcWp9bU+/+ri+Lfb3QK0HskbwJwQmEEjISmZZGMY7f8aJc579
	jpgkfEWQ5gPLfYCcLmfRDftAf3irQx3T+U10EY09LRYcPmjbMhKw/oVNeeMcUS
X-Received: by 2002:a05:6a00:88c:b0:845:e8f3:bdd0 with SMTP id d2e1a72fcca58-84fde2b6841mr5495706b3a.33.1786708595434;
        Fri, 14 Aug 2026 04:56:35 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3d9sm366669b3a.11.2026.08.14.04.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:56:35 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: Jia Jia <physicalmtea@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 19:56:11 +0800
Message-Id: <20260814115612.127842-1-physicalmtea@gmail.com>
In-Reply-To: <an7JAlFpRVOiC4WQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com> <an7JAlFpRVOiC4WQ@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> In the v3 you mentioned that this could be used also in vhost-net and
> maybe vhost-scsi. Would it be better to include the other patches in
> this series as well, since we're basically fixing the same issues, or
> have they already been merged?

I did not explain this clearly before. vhost-scsi itself does not
negotiate VIRTIO_F_ACCESS_PLATFORM; the fix I referred to addressed a
different issue. See:

20260726144314.1652934-1-physicalmtea@gmail.com

The issue addressed by this series also led me to find corresponding
problems in vhost-net and vhost-vsock. It now appears that these are the
relevant backends here, so I will include the vhost-net changes in this
series as well.

Thanks,
Jia
