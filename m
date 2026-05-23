Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6051DFDAF
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523707; cv=none; b=YsqcNi6ohnoDXUAbucM2kamcgodwNaqZ/xU5hiyzbHFCDoZjCZl5QlAKp+5GskcMKr0fYALrjCVuu209cxommTID+FVyX6QmKL0YHyXWA4Udd5RILOIWmbcqFzduArnbzCz8oY5PHXrfDyL4dM4Gk7WZCudq3eJuUCeOqWEMWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523707; c=relaxed/simple;
	bh=tt+Mc4JndboWKa9mcaa+6h974T+Ct2nL+dxQdx36oj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwla1s3vBi1CBqf73v2wrMJ2ISXcYm+CyOjVjmwKwjCYukOSNrm9htDEdqVXyVVei8J8tUjoEhO/meljSdur6VJfKcBxzHQa3u2dOu7deB1C2iJtDKI+1AsnWByxiu3PTe4BQjlYIg2V4Yl9o4h3BElAWcQ1P+jYrR3OHa+yDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyFoV8Lf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4Im7Qiq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyFoV8Lf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4Im7Qiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779523705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tt+Mc4JndboWKa9mcaa+6h974T+Ct2nL+dxQdx36oj0=;
	b=OyFoV8LfjPEUIztBbt7Wzh+avATxJ49ZOy93l/UqtT7tXcwMT551yX308ZIikS9GMYjlnm
	k/4sNgMr51JwT5zUkg+WN/dsGxbpkx4bYCkG6S3LWRUV9Q8WTH4b25U8R2I5MS8eCZ1mA2
	5a2sXx/lWCJGnpxcAiQ8AleGpA/G2Ks=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-hpANFfy_Ot6ypOjKNUp8Cg-1; Sat, 23 May 2026 04:08:23 -0400
X-MC-Unique: hpANFfy_Ot6ypOjKNUp8Cg-1
X-Mimecast-MFC-AGG-ID: hpANFfy_Ot6ypOjKNUp8Cg_1779523702
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bcbb3e56f10so730570066b.2
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779523702; x=1780128502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt+Mc4JndboWKa9mcaa+6h974T+Ct2nL+dxQdx36oj0=;
        b=S4Im7QiqUKn4nrC+I263fB2OvcxChFqAW2qBraY0RzOBjFAe/X6q3f20YZLMGRMZ7G
         NXVphRd3WEKUr01x1BzgE0P5zePoHm2M8H8iuzkomZ/9NjjKzX58HJmU6jNbDSyPBn22
         BAL/K5nfiqvAaPTiuFPngcsZdl1Ty4Jw4uOYO1VN33MpAFi1eoL1NLP9A1fJ8qHWaidn
         DYQ7Bhrf0gAmWIAlGj7EvOD5o9k8v7dVmFDGnDwVUOdkRgVWD1HrD+nZbmRThEFb24R7
         mRLd1YjhcGp1LAQM4odsGcEuraaNN3cxJyeOn22ORQoPv8JwcuxXCpyFd7GnggrFGssu
         QF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779523702; x=1780128502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tt+Mc4JndboWKa9mcaa+6h974T+Ct2nL+dxQdx36oj0=;
        b=KwjsBs8Zhg7o1A1cRB2yyMmj/oFGjvEx39qIlh8+QUeHsH4jJ8UF3Tpjeji744G04J
         +mMiDa1s8WdeHwb6RUeLiuYOIAOHMQot+usqUOI90aik3w+liA/qLUJVD5ABSTBAKkpg
         2aztvcYMRy+h19BWudQLABXueUe9JgBqmgu4/qGKtS3Zon2YsPUsJD6pxhxYDIDJEhSY
         Pi42OfCZiwkW6mkPoMlVqVthtV3IbBpedTfDtVNuvZPQz0H1csc3NP4IvG4Ehcz4jFlJ
         8Yg5YSJOvxIyvxmFwqiAPEcave0cwZ0r6quEXi7/8d43R+BCEYyEOOYwkMp6NCkLySz6
         mwLg==
X-Gm-Message-State: AOJu0YyjQhutrKQ/Zv+tMTiisEhX+t0Q4VSfjqyfxJ5uNFZ1/DSVDppm
	BlXLYkxZxjroR1gkqRqZZtUT4WIW7ROVXV7Gdzl6WO3cbLMTr3EBjYq3119FStZ3VJjykYP4wtb
	tJdD7nAFTCBOnaT8iHERdoPLCS+8j2AYaIQp+87vCgKjyfWQKr2v3AsLQ6ejscnGw
X-Gm-Gg: Acq92OFT91RyZPzC8wOebX42lOFmlzEnZY9Kq5ffK+QylY4q+3ia0Y7do3pAjZQkiYO
	oFzQSEUKeC1K6+6ZiHNqrANsMXYReAs65doB74UQQDyn3Hn6DR5wz5i97AKsUcnFBRjL09orz9o
	5Q/ooMbE2pztHLXkUcJj+HIL/zT9Ect+xGDQ4YdJZi1a0OipsFdp9CgZXpmrxCIvIeBGCf5sBOH
	RGJBJYbmxgIDRxe9gthczEJPtEmbfCPxTG7635XJ7lBk8dfTF1nzeTjR7p0VQKD+QgsTMmVEKZX
	3wfEQH94/+pysBNVQMZwnEgkwT2E8U9FMVXIZovgBc1+Zouv/jaoBN6ReajQVFGaHwPyft0Rmzq
	qKj4cEXajHobpxAKgSHx0sMQApg9AZ2ZXjKu3oFaxD4IfXHuKp/rapULOSV7kGe2ZuJfu1DJ+yP
	3V8JH4DYbB/gnGODadTlifUyINy7p6S1/eV4Zp
X-Received: by 2002:a17:906:8a62:b0:bd5:27b9:4a26 with SMTP id a640c23a62f3a-bdd25bea169mr308309766b.26.1779523702323;
        Sat, 23 May 2026 01:08:22 -0700 (PDT)
X-Received: by 2002:a17:906:8a62:b0:bd5:27b9:4a26 with SMTP id a640c23a62f3a-bdd25bea169mr308309366b.26.1779523701929;
        Sat, 23 May 2026 01:08:21 -0700 (PDT)
Received: from [172.101.1.88] ([185.48.102.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc30508d7sm151671966b.18.2026.05.23.01.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:08:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 0/2] KVM: x86: Return VM's actual APIC bus frequency
Date: Sat, 23 May 2026 10:08:02 +0200
Message-ID: <20260523080801.155423-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173526.3539407-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, with the commit message changed to appease our new review overlord.

Paolo

