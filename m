Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF43AB5DA
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293026; cv=none; b=CUGCmkfL54ijXbTQ3yEQu2LcEW4rZfoAQlg7KgRqiCFFYQp8LQvTk4QuoN9QEKRDU2zDx8zF6t6txVyx6LY7dUA4s8wMhDWrQoQtYbofqp3gir4BckbOcUFCDenJ2tdaNfNzsR75aYggW+3ZABcFfiLoXdU7TMMfk8iwNvWAkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293026; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulxWsLiBiX2sVMA3i2GHPHpKGa+EMntGiQ+eJnjpHHsFrzrVW9u0G879WkVUzYFzJpOH2XitWIVB86lWBrYgmPhUK0kwS5BECxSdu2VANzIw+BfpSu/xtRZ+jV1kU/rP4W6QIQwlTDdhKSxSPRCO8ozqAvTBxnxd+fyIBfKDqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciZZl/Gt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yh1i0A7X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciZZl/Gt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh1i0A7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782293020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=ciZZl/Gt12CpXujqdOWK3+ftpsUHm509I+2ALLar/eGo/wXi5keVwcp5HN1b36gO2O/ZCR
	Drze5/PG0PiirByL3LE3HYC3ubl4AfwzxlYIQy3BnrzV6NlmZwOhKB4dJxcte3TF3dCrFU
	As3ZASMrRaDKTafzs1UrU1wob/gU2jI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-ldEz25CVOdSiwOI5JtIMAA-1; Wed, 24 Jun 2026 05:23:39 -0400
X-MC-Unique: ldEz25CVOdSiwOI5JtIMAA-1
X-Mimecast-MFC-AGG-ID: ldEz25CVOdSiwOI5JtIMAA_1782293018
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45f3d008865so598406f8f.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782293018; x=1782897818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=Yh1i0A7X9LogNPLpN75ulmYpfnlEPmtl/3O5m2R7GlIfuEdo2jb4cT9hNsHsMWtuf0
         NMR1GG1QRjUtRkm/qDG59fbGMfpGHJZ07SBptT/mfppU2rEG/WNrTCryvuIxc4LGW9w6
         Bp2TXgjMg2Wg+bbikAogn7lLfHKg8+qF51yv4P5Gg5dNNC8fB4iJdU30tSRLE8HNxDz1
         cpTFqZeTjtdgz4v7Pmzhn83pkyqs/ix6ALRycaRFjKJmfVtM+v12D8dDudvmI6mOYcLq
         UImoXI28St0YRpLyAnVis/tSkoO+8qViOqWqX26bfshBtSetP/5P7O71DQlVDkt5lrNP
         4TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293018; x=1782897818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=VQI40YaMdu/tavwm5tYOWEg8bVfM6gX3DtkUT/DHmVwds7DOClW+iKJIKwLsW7rRwm
         YQR7XKEZ9GZwuEv2HjPgIywTe8cZJPyKTFTEejmy/58T+HJxkCKzUkuoF9Y9g+htzlUg
         CeXRTTC2+iNVY4DRFHT7lxfO6+fvb4gXhxw5A4CkkU/vkUL4ZIe8L6F/zPUqRwacbgtN
         XW9aqqz7I5+5A8Dg0479PmO4W6HoFUk9qf+IxRy7RUBJgzrNsq5eJQuX0ei/2wmpFQNk
         y4Mm0jKEnvUPum3KpcfoN/Z5QNZXN55+rv7XJ7twr/DQpkYpYHa27EedNF8jeqph5JQD
         JQSw==
X-Gm-Message-State: AOJu0YwI1e4AjyWZjiecM4w5Ew2SZP+uyCDVbcWVDy5tF+uxUz5FFsg4
	20c6uffjzvwKqbmUfcy2JXAae46wHSOQdToQaJfCdSC0noefZIBzf9gvL9U9ueIqFPUUpy1o1T+
	t3RzaE9SFZOKL92/0Tqilxahkrkx6X++LbPttnxjkdcs8lhPfxYhGNQ==
X-Gm-Gg: AfdE7cnWQMCcYP/eIBdEBvpBqok4Nc+mFzLOZoZJBV/JzTCsq9/c3lwmwrT7rJZDpa9
	+jGxabMNbWXxL8ZDXTa4A7zAA3AuQhVvEtVJa8ft6yHd9V58uzKk+xl1hYGUZYpJ4zG3ssRGKWj
	ndZmim5zdIpQMwD3xGm7vOyy6TgYu17MArJZVhIfmrZImzPjhaRPGgcw2E+5FcRVxeKjMRYwdkd
	u/XcUSWPOHmywc2jtOS6nBggOUAz2QrAaMqDZ2izrantawFxec90nFx47FlbvehUlOcW3Rx+UmK
	ovZrs3/va0RfvjlkYNVnM0EoQxe3o28UzMZv3PGt1meWeB6F9l+ihSXZr3NE/k0XCzkQx40M5wx
	y+2LOI9wNqWA9NLM6ss4D1ZGXwN6PyqCuhQys/u56hYcGmkMVAXnu7lXMJzdq5VTo1+WFJPHBPP
	vhqaStzGjkOLYT5KGt
X-Received: by 2002:a05:6000:250a:b0:463:3184:6310 with SMTP id ffacd0b85a97d-46a80f5c67amr12263920f8f.28.1782293017871;
        Wed, 24 Jun 2026 02:23:37 -0700 (PDT)
X-Received: by 2002:a05:6000:250a:b0:463:3184:6310 with SMTP id ffacd0b85a97d-46a80f5c67amr12263853f8f.28.1782293017238;
        Wed, 24 Jun 2026 02:23:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm5646938f8f.22.2026.06.24.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:23:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
Date: Wed, 24 Jun 2026 11:23:34 +0200
Message-ID: <20260624092334.970697-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612225241.678509-1-seanjc@google.com>
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

