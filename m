Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E73B71AD
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294802; cv=none; b=aSb2Dql/khxCkGbEhpT/MmqW9Kwg/Sg2KqwOPWm9ztZ4/fMEhVbmBWHmlNLeo4yBVsmnc7dMfBiMLE4sYWClx/1xoZckO2l0tWDvyft+F4UzaNBQSWNEmuAzSYwP2u24X/VkKa1GcXATDbigF0XTjSYzo61LPouio7NeatMHSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294802; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBNaeElqql8wnI98jf9NLFOdxnEQpijYK+RbMzYsp/CxYvJDQhlVOJrhihOwMEIJKkYFReoDfPOn8r6900uL7UoND58xfpY4v1eX4af63UZE+98D+wgF6KeEYPXd4fvwnm65DC9cy0lsQuTXfb6385txoDBtO8D4mEFjjmqqWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKRUY2mh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lkBdLogo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKRUY2mh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lkBdLogo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782294798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=JKRUY2mh5hUFPwDPMJGGekocwd3mZRc7PVOV6ccnKruauPPMEDn57EjnC0MkNaxgS6OEQL
	d7jfDxSZSOK7+GC4MZLzzl7xv4GBptnUXyq6QbYkOaCYDvKRigP1kGVcWUFInvghpqOBiv
	UIYDL6d2dNWew9dWkjI0jzW9gyK5oXY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-PDpC5npPNyGBj_EY1sz0iA-1; Wed, 24 Jun 2026 05:53:17 -0400
X-MC-Unique: PDpC5npPNyGBj_EY1sz0iA-1
X-Mimecast-MFC-AGG-ID: PDpC5npPNyGBj_EY1sz0iA_1782294796
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efa2f7009so502805f8f.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782294796; x=1782899596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=lkBdLogobdCmTFoUahMGXAQWeu3FHBHavTAQAEVkJvnWXxxZxCWmo7Z97XeHD9y6Bl
         GMM+kwl/P1Pwa3edLI+F0FVJzRKtTsHuR12U0Y81Yj6RqtHShTDPTcQXkX3WqDOY7T+4
         OcZcR5Ug0XzFx6qkECGoowXtNM84EHYJjWsjYKbii3gYk7g/zeGaknw541aBYREQ9FVa
         /jZlICvffCcBWJtc71bO5vTqdzHlUPZg88MHjdhJZKH4YFaHr3xv0jkT5lwwE9uT6hzy
         5CCz/4s6KDRGWGgo7ztx7o4MQJXMtDpWpuiNM9JdAHcfjQ6aziJSf+e8J7mQWpFCRnzr
         cocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294796; x=1782899596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=nF9j97HVJI8QS88J2KaRg4yvUl+26AoeF4MIFDaN5dx2KCgtL2y7BIqYJ1bMdHUa9u
         Wkd7fy2RgASPAglDxFjPnld9Knj32WqX/lAQwJ8X2MHbV7jliVnkAkXrI0acLZwP2o4I
         5VpEQCBmTxHIQERAvaGeRTOe5Xf6+BPHt3+n6cTr4JdDpoy+h4WbElIuzy5YOLK7noU+
         8N4wGsHoWgzETS58uwfC6I1A9b78KYy8HiWdzJTaCMfW5d7PriYUv4+j2mMKFC/XcR6j
         KKPwcZEEr6WBbP4j4V2r4M2d+1DbFKpku8V/OgR9jgGH/dIycTOb8DkDnhnINqHg7Ntp
         zYuA==
X-Gm-Message-State: AOJu0YxCxTB8NP9SlMyHwC6KWuak2RZoqvXzrl2/ey96/TpJlhFdovhx
	5FpBSAkZ+x4U9v/xhW1eaZtghdYocDSTTOIsBsLL4qlAyvKSoloJ4NDhOJu/II4I1ejhB+n9oG7
	9m/xdcgH6TyutDb7zUEeCqlhnWEsdjtAw7I75S+q79la5YQC7cqilJ98vaBGRQw==
X-Gm-Gg: AfdE7ck4CK+1vqobqRZ8z2judoNl7uYkJfnsF6lmjA9WMRbq2w/vd8YhtG6XksQriih
	ZiImDYg19VW6S40dejvd4aBkLtovPDabE3ZWBn/UDhYT+7NL7ADcacviyv62yNLH63x73LNuyea
	/91wVBvKaBX5GoXkq1MQj+zg1nhjSoCPzTKCsfo+pZX1pvTI3N14DnXorZjUUk/vhHXbDrEcYSp
	zUspYSwtXEJS5qD0jHjzqeiIf8pEdGYcycFOoF+GGv71Z0QWF9/75p62IKc9XPRSfQMOO9yS8Kw
	A0LO96KhOQCxPnq2dOzfoeoryqvIjlDiNUV7NhFVbz3dKeY+zlGBaacgvkV/aOLB0hqGvB0ncN7
	k0M/p6IOfggk0uq+C0VFY34ByS9Yx3r8TVNTbvTrSB49p7sCA1hjp7WVbus69C2HvaVDmVCytAn
	rK6wxKMiqhnVUT7jvv
X-Received: by 2002:a05:6000:4a12:b0:46a:d1e7:4516 with SMTP id ffacd0b85a97d-46c084c8186mr4246794f8f.6.1782294795917;
        Wed, 24 Jun 2026 02:53:15 -0700 (PDT)
X-Received: by 2002:a05:6000:4a12:b0:46a:d1e7:4516 with SMTP id ffacd0b85a97d-46c084c8186mr4246763f8f.6.1782294795508;
        Wed, 24 Jun 2026 02:53:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm5922703f8f.22.2026.06.24.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:53:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Bug the VM, not the kernel, if the ISR count {under,over}flows
Date: Wed, 24 Jun 2026 11:53:12 +0200
Message-ID: <20260624095312.979729-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618185350.2020845-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.

Paolo

