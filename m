Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701012B143
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254034; cv=none; b=Nd3ijCwBvVG5x5cubnoUZAiiHMRE5HQWYacUWuWuggQqpUs7DlEUBbPwalOsSw0dYP1toFDzMbKOjMX8mq/zm9KMBJPFE8UNeFwtUB7EkMV0BzhTMS3LXrI/fQKRl8ePi0JTk0Nm9sywBmq4lHqDmB+tdRpsWj18TOwk9fvfTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254034; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhMn1gMJ0qWEUpaIDKuXrbh9tZOH58qan3RZS6K+qtC5noW0+dzq8z6am9q34u0QRymhA2sh3/kAWxKbXjyQ506AbzBH13J8bcgnjSpGPS7uVkqn6WP4xcV8ivQPZ7ZuOmArGRKGM1V9Ph2gWksdWj6n35Sw0AAQTfJ8VEEBfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ff6B2eLA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHTo3+OV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff6B2eLA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHTo3+OV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781254032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=Ff6B2eLAPhjVpADG1kd4MXKknsUNscDo0vvzJuYkn0oD1WHjQIO9idNplKfy2Iy1e84aau
	0cEq6fqFoKVwIVEy3r7QtAxyY9J+YlbfPzAMDk/34zmYtOgINVr+ucummNFtrUrT8QsEAv
	vytCIgx/bQM61QzhzXqqfGrXi8IFV6M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-dIDcHF2FM1OI_bznBqcFoA-1; Fri, 12 Jun 2026 04:47:11 -0400
X-MC-Unique: dIDcHF2FM1OI_bznBqcFoA-1
X-Mimecast-MFC-AGG-ID: dIDcHF2FM1OI_bznBqcFoA_1781254030
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490aadb1386so9130905e9.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781254030; x=1781858830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=HHTo3+OVm7v1QLrphfno+oepdTsgG5ga6kUk9tjcs39byr2HDiV12R+AYEAHShJmla
         RUC7kybl0Hm/nXH57BiDHCbk2/8c8NInRg+vdOfkrqRbuLmEHvapc3yp9gwQruK7oyzs
         5FVOx7J+3fTwjpq0ldwhgZ/K88SZoMpZqTRpA3QpzyE/2IVW8E/WaNeIPCh7Aa/Nrsdj
         oKiJXGli+wiJha0aOdfMcoFZ36Ft52XVZGoJyuL/Ol0V3fCFDK0udaOCHUe5kCjYhcnM
         kD7HdkyFEtf+z8tKjLsSsiw9OwMqn6shzNJg1PIVRgxq2KFH6jG+1tayGS3R+jxOBSim
         he+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254030; x=1781858830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=k6CBVIWxKr7Zd8aljGi44HwWMxcM9NP4nt7M7ES4TvWsC+TH3mxdyo0F7g+qoQjnLt
         UOypQCgB09TwbNRDPu5pmcdWjquerQPDtIVy/QrdRoLbpWAeJ7+ORPFEubS1PUItJOO3
         VHBhhmQJsE0dL4b4epvjXc+G6ZAmtYIMtiMCtHYsEi677sXgPphZyAQwSjHyxwF9TuN/
         JtxI01JlMxku7otrIn59t2rYcNzYQ0KPldIpbB1p0+2tXfi/FmQQQuQDMB9DEi64aRS3
         oCC0j+1r8H99FmqembKyUhMCr9OCp/Vb+no/f8Yb0weLBba1kq60it/nif5w4+Oh44+x
         TiyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+d/hDeXwtNyPf4WhZRrm3D87vcz/EVdrnPhJhpAtMOV5pNwl3pD6iaprYroYRKyQ984Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlgE4tjDGuHgVBUt7nsfUsr/xkDzzhBhWsjWSk7qjUq7INqen
	oE4i0o8ohWZBXT8Up+lvpBcVIXCOLeNMDPLHzyh42w/rDL27WKsjd2ntxO982QKwxboHgA+048R
	E/v1xU84Z91A6yQbFRpVYmi6zEA3mpw5qNeN3K5yDaNZlhIgZAWyEbWJm19enCg==
X-Gm-Gg: Acq92OH8mGkehaKermnNzWhXGKBdVE7b+d5t5MruubWVX2oEFamdnNzoKmh83PdEiAc
	ur4yvLvW8Q9vT5KFDUTlygQbiaqqCvxxKrT+DPJ+q43rDcy/IfcC8j53HX3WWr7zG5584yq8u5e
	3HBWDeqnZM8soaL4eOX9oBXvTYwlHJXWKq0Mpl1qnYXN2e9bu5VegGMuXo4d/3SVTvbh+Vb9IdQ
	nB2yeqUF+Y/J5WaTNZWAMtpN/xZ6I6qF9PJhr/IYrl7zNLvo7hQY2t+JU/C67YofrRuawKlM0Tp
	QvJSLORukIEBL25PTC06F4DpWkO3YeQOsCtGjg4cOM9g6tazRAd0fe0oSYspfs4lvGi5MRqYCJy
	qlMv2jnHWs6iXWIR7FxXdDM1OdaMiE5c0tgDn4TS/7soOwBzvkbdr6n2h8+OJI3W/fGYd4YHsnW
	8oK6WhRp6aeiFjvr/krjJss6ha7pR61aN2OBUJUu8kGiQS9JWDfCQ=
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490ec4dfb03mr17068415e9.14.1781254029906;
        Fri, 12 Jun 2026 01:47:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490ec4dfb03mr17068195e9.14.1781254029525;
        Fri, 12 Jun 2026 01:47:09 -0700 (PDT)
Received: from [10.201.49.111] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea84cc32sm44932865e9.15.2026.06.12.01.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:47:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	seanjc@google.com
Subject: Re: [PATCH v2 0/5] KVM: x86: small MMU-adjacent cleanups
Date: Fri, 12 Jun 2026 10:47:06 +0200
Message-ID: <20260612084706.1868591-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530165545.25599-1-pbonzini@redhat.com>
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

