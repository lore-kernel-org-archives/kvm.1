Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4639BFED
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294843; cv=none; b=WxQbcz0WIuN8BuZT5PTqUQ4xaGM2B/eQkwHyeuL3QvaC8moGfhwACHSERX7ujnXufZh6ZLGwN9qL/qswpmkwnpE8oDT1ABDXTP7UxvvoMuEuAqdkjnt/XFPtwIGdAIYjf4uwYpNhZqxawvzrLDp5XPMunlpQLs6VaJlmc9xZQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294843; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSuCcvl/xRcz/U7NFI4VPis5mh90b0+GRJigbkcxO0SOSiar7YSwGt+1IWo/36ltoe6VugGwEEK4ZiVyBCch4nUoSbG0pVEUCZtusN/ouO8qbV9t3oeaBl+HRgWPXq5Uf/U7bItb0J1VyIwYEr8iq3t7tS+4M4fvIhQaj6Yd+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J13rsU3Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kx1aqvja; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J13rsU3Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kx1aqvja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782294841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=J13rsU3YEx/EVdovGAsSNaw2VjZeV8r/+ab85dL5H8D59H53s4Uly8UoGwZbV5fN9X4dHM
	ECCIpoM4Qnni2Eq1SnhysR3+mOHeBgnZONx2DH6z/LUg9HhkR7xLmNdejFHRNUjZk7iYJW
	KAPhNcUoqOiRIcjq/QAnNqEarwcw9Qw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-6cXz82xWNe62dIBF_NDq6w-1; Wed, 24 Jun 2026 05:53:59 -0400
X-MC-Unique: 6cXz82xWNe62dIBF_NDq6w-1
X-Mimecast-MFC-AGG-ID: 6cXz82xWNe62dIBF_NDq6w_1782294838
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b5d2e394so5160415e9.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782294838; x=1782899638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=kx1aqvjaWD3NJADBhbUpEB24/xW0DpIiE/XqanoFUq9bijcRYB/BzGRdbfoZIPlqao
         HCya26a4XLU+Vfa6Esuw4XCb1Z2dt+pXcYaL4oPQOEnDbaVW/AOPtUrIX1tOnBXafpmS
         abeuhOo1JZdsQGbZKfeCPxymfAsvQ5BojsqX0H/DUppZIL3ks0AdEbibl7kNjXe50zgR
         niUCURDFhA2K4mTI3gjyeCbIYkxhCF1os4MOetDnPi5MGGId1KlvbUxt4o6g+aRu8c++
         Dar9qGxeaNktX0xf1bo+ryLjHSsnUloXJLTUj5+XsSJHZxd7yyHz7itmAlC9CMeaD6H2
         +yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294838; x=1782899638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=oyWxIKyG1H/rJzh11axGV+kLR4nVnptk7XgmzulZ8S1j+WV6Hd2pHv1CwARieY8CKk
         JYgSj0XPJcbOQzkMReEYwsLPpwsfwVwfLyZC0RCzu6PmK+i7qoCoqzcZKnfPrWA3iiin
         0I/Eg8eElFDUXWd0n8wagLwX2Cjj6Suws5NUMyl8P5vk6zbGWpINTQMP0F6bSMNiVCwn
         T5br2ZVSqXVr3bMUjVIxo3Xt2ZN+qg4J9aznDUS6dVfTKIyj7exg9BZYzRrDhrvIqdEq
         gF9/l2yBh3hbiDryDH3/Y0Viq6smn8iUMcRy0a4MQHjXrBXAeXPrnjWKq8q+OMPnPXnC
         jloA==
X-Gm-Message-State: AOJu0YwvPlDscYXiDSNbUZGbNGqHjQsYUbrohm9nOdsExruIlzb4pbYR
	SwxHQGXlfjUe18sBJ69hSLz4lipYIpEOg75Z+mr1Cs/QrR3ku+0qR45COeVGUtePeQnxkgudgu5
	BleZ0/Pq3W1acrkNSgDEDBrz+swX+4YntE2ndRvtlMIndf0o25g59hzKJUj9YeA==
X-Gm-Gg: AfdE7clCFWFCaXPx905eThmGL35Dt1znec+Owos+E2Ha4dKi68CLD9oz3pXITGckL34
	gKY3CcELCzX6Jh9CdVQsMcEwVZAVOh/7T8ae5vRhjLZaL38yJV32Ram1IgTKjTMUHEAD7O1dQKI
	HgcGNvY1FKR153+BFHeI7NJWLZ7BHt6MyZR0vfqqT0PmFVbhZXGI4vCjkmjPpReznDaGBSbybu8
	PGOms5nCG01gXL5qJQnpqhtYcO28uIVFF2CMyss6nQjw4R7VtPDKAr4r51TtBkp/2WQmlu52Ye8
	uK0JnKeOdIDFpB49+wb9PznDOwRJVvpjvaM3+Lgl1bQCZAFEgTn3CEffhzmuw1jKU3q7ymqylOZ
	OC0+zFVU7Tm4n32HAjVleHTQ8cuphGlhWusdegym4sjT/gGLSr9/RqGQk2rkAUeZkOHwb9vaVl+
	hLSAokRGvYJXfwgWHH
X-Received: by 2002:a05:600d:4453:10b0:490:c2a3:3303 with SMTP id 5b1f17b1804b1-4926088046dmr24860645e9.34.1782294838479;
        Wed, 24 Jun 2026 02:53:58 -0700 (PDT)
X-Received: by 2002:a05:600d:4453:10b0:490:c2a3:3303 with SMTP id 5b1f17b1804b1-4926088046dmr24860465e9.34.1782294838176;
        Wed, 24 Jun 2026 02:53:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm777106775e9.0.2026.06.24.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:53:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: WARN and fail kvm_set_irq() if a PIC or I/O APIC vector is invalid
Date: Wed, 24 Jun 2026 11:53:53 +0200
Message-ID: <20260624095353.979995-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618185213.2019937-1-seanjc@google.com>
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

