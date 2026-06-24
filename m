Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AE3ACF14
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294889; cv=none; b=sOabri3ImrZnwfg1MaCvNjxfknBFaRV4Dr5vzASFQEXTsgllcF5WjpHytiQkiA+/JhLIfyGaPA2tR/8N8P1yNDaOGRUTNI+Rp42IbrL1+L3CmiQoep5pwzGfOM8vC8eEKAtZuSPvuTZc/G+aOP8qS1iQp7fZi9iunc0Lq/rusmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294889; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nejmBIXUFCvXAGCexrzzY5jsOcCgaGIf69uNbjR+wEAWGusP7/yOjmwpcVUPeZBa5++7tUe2czqnLAF5r9eX4+xNqUbFKgwzdphbi3uLkMEqsHyA/HXJgPZtOSR7S3zJKTzF9zyDuOivZG7Aj4GHRn1x44yXHE64IuR5m+wfV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjmUF77b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFA1dvLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjmUF77b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFA1dvLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782294887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=IjmUF77bCt51Op4X3+HFAKxBr9LuuJ+iEff4kBcnm5cBxrGrDbcx5f8+dt74sVYLoxYXLI
	FaAZOyph1c39cSK8IxeMURSv6X6QMbS8/UlRDXuVRLO+Bae2a1BtlGXQmwg7t3F8dHBfSh
	NHNe53CK9/prnzSCcAoNa11kjeG0zAw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-Sz1qEvLJMt6QCVP-enIUAQ-1; Wed, 24 Jun 2026 05:54:44 -0400
X-MC-Unique: Sz1qEvLJMt6QCVP-enIUAQ-1
X-Mimecast-MFC-AGG-ID: Sz1qEvLJMt6QCVP-enIUAQ_1782294883
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-492488f8583so7815125e9.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782294883; x=1782899683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=KFA1dvLXHJuhlSBySeKcrLn4vtVhLz36a5BLxj0VN8BiHZYHklCRD5kjJzNfMMIVfA
         rZOqkaXX+AS1lX3jubmdkN+9244azM2tzc5hUk+8AdoVBRjrca2y7rv+08tjHZtY0ktk
         B56XSJhyrwCzrRHjKlUaJ70BRYE5L+MokP4f37m9yhjVibpRG0Attu5eMv6EnZTbeNNC
         PM/10A4MkBWCdOYf4BXUOOrRBNDwdGCcV6nGsO9UqzpCPdE2wcswgjn4zXVXeq7y3W/E
         yZMaYTzSld/5y2rhEFFg5rU/mQ704O5Ag6EkVdpc2EvJwuHdT/0CQSv8HkO2VItIbA25
         ACng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294883; x=1782899683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=GUV+aHVSwMDPrnfzWuyknwj5bU2f2+k3Tfim3nPbxVdASBZBN92r95939Ipt8pNhUw
         JmyN3Dzf1Re9XsjBfOaJiMhKTjQxklAFshIBUQigH3azJHTPAaaV0rz4cBXlpzR6hQkS
         3e4M+zVVVvnfNJI/jW4DIWoucuk17ZbIV99JYfMR+8be3UAo5GtvBrQMM6Eg/qQ06wJf
         o79anAGCOcq6m2bMmcZDhTc3mYPNB2IMu68kFv4sNC1KhG7hVBtczCe5XhhlJsst19js
         Yov4karR21cx5VzLt5z6WOPAwnYt/D8eG+QlrQRpqotoUNT5Q8xPwsbFMIG3WoRPQfc6
         EFmw==
X-Gm-Message-State: AOJu0YyFLZIkMEXwK7CgtSKwPwU0s36NrYu5yG09pmU5w1ZCgilz8wlL
	Meex/L3iy69b2UHsxm4D6oQjfikKRshAvqpzmm3Ny9xbY3TphmKqkHJ1rfzsmw4JqJS3uUzwtBM
	qNEx5ykGfTOF3o+r5qDqWlPE3v+iyVS085ME/yuj7Pu1WWZhRp2JQ7A==
X-Gm-Gg: AfdE7ck14C2AWXjCrBV5nIf36MyxL6QKW5ve1TXUu1zg5OOS9IaadESoqapXchjG9N6
	qBefagL2xo7euxlHhGeId3WGxCBAIyCDjCcgvMQiZF8bjWjkZ1qjVq+HJDBSQ+1PnN49Q9OJSq+
	wLVzCPSovI01jimLJ+CtIFbFDXCpmQNAXRu7bl4N4n18uCm9S01/VZqSXfnjgXu+Cv0jQZ/XSKi
	z5IY9keTMna9brE4baw2atBk9Pdv41ZooeIBYVc4zvJ5mSJQa7DGjPs6xuLV3vSsbElFqSaZL+v
	hCySefTHhOGq1ucLobP2hkKBNUG1mhOi/aZEbWZ6JvNFgWhwhPg9zSnqD7+j9CaTOlWct5Luu94
	+Y7lM8ynY824Dsxcr7ge+QHoV89Cw9sGgE2kpaYlMsMF/48IeftQaA9MBdyxXAEwI/sgjobfHSL
	UYqEj8+xzOcyvsZQ55
X-Received: by 2002:a05:600c:a012:b0:490:4b89:535f with SMTP id 5b1f17b1804b1-4925b34a2d0mr95755055e9.8.1782294883016;
        Wed, 24 Jun 2026 02:54:43 -0700 (PDT)
X-Received: by 2002:a05:600c:a012:b0:490:4b89:535f with SMTP id 5b1f17b1804b1-4925b34a2d0mr95754695e9.8.1782294882546;
        Wed, 24 Jun 2026 02:54:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1eef84d7sm5798626f8f.16.2026.06.24.02.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:54:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: WARN (once) if RTC pending EOI tracking goes off the rails
Date: Wed, 24 Jun 2026 11:54:38 +0200
Message-ID: <20260624095438.980451-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618174527.1982333-1-seanjc@google.com>
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

