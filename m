Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688C385D70
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126598; cv=none; b=mtzQLMh3szZdD6yOFEAPI0YDxdrSFjE17i4lPfAhOy2+3dpFnUwQL8DIKInU+KnXhpwp0O82OuycLpLOSlq3KgG/4jO67/XukqN+Co5Gym1mG/ycwdFpmBT+DFcQUx+/rzMFzu3qhXv1UBD9Vom+PL6BTtOypVeGKnK359iLUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126598; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPXPEwtHe0RxZOTymvFMWfejghq70aH1N8pxkb3+8FWWtTJQa+tKbUvsHKLXRlFJpamZlJBK1WQxE2l3R/NJlvM5gwXo/w/t9RAkktFaf4zRcxCaaA9T1IvWCswBi51vwjZVPQLJQZl2YBevRIiER+v3D9mzUBs1H127E4kPLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUy6INnu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrMhcxR3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUy6INnu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrMhcxR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784126595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=IUy6INnuK1Ca+jXEuHzUAwguP0txqQXI2cEgQEFSIbIZSgavyEXq+ZU0c5fFYvjBlaYTIC
	U+G7VS03Z3wuKG67Rx5HleR7v38P8UoezUlz9+O3pcIfiGLjy3AxqM4tUF1lV8yHwkzfPq
	DaVBviWGvqVTFWSC256+DbTawGrZbYw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-F0erXKt6N-mSZTie29qMMw-1; Wed, 15 Jul 2026 10:43:14 -0400
X-MC-Unique: F0erXKt6N-mSZTie29qMMw-1
X-Mimecast-MFC-AGG-ID: F0erXKt6N-mSZTie29qMMw_1784126593
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so50207765e9.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784126593; x=1784731393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=CrMhcxR3RjLcVj6xqVMmvlRN3vJ8fApkXC+u5/CE9JZBrFacpgbUOEnr4s5/4NIYAx
         wI8e1Xz6QzU0Ii5jTDgGQao9JvyV/JRFSNrpFOOBWaP3VFNxQ3Dx5TgvH4mOWr8LIENi
         FzxtR+/KiOdst78PTlqQiMN8GUPvrNer6Y/clviPWLxXqZ91GBdGfYbN/2NBt4EjbnE4
         jnzdCn+aAU06V85VxfN2FtPfVQ7EMksuiqPz1e6bKgggGj1BXHZ2kBcyBY1MhAR2p1ns
         IPfJh9oXWGpHrxuJGxZsFQJ1cWC0Ks3kcP7cAhXxDKsbbvtGs92W03aijoq0dgA+eAA1
         qe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126593; x=1784731393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=IBM3VEBeEDVMZSfP51M0nNYNwteL06ND8E6bPsQ5AXUZz6lcbdgJyAsT+GW9jmIl52
         Wo9k71HdDLJt8ndVw1H8Whmn3vd5uDAgDT0sRfdwaFcdfSxPMswRIph5asKnKAD26nW6
         mIhfPMWlX4ltfnMj6Xb0/EjZ65l64e5lwKlrEHTEafNQR8FKh6g4KDmlq3ieag08obXI
         hCxmiq0G6sBqJHkmL7DlTSWiOOKjkpKg9sQ8i4wvCjZC7+u+Gyb7eS4NGwjZbLEyXUO4
         FuOpoEp2C7gHlwwmcfoDOg9/bGCFCKTVYi9yravMPn+8P0NsXxsMZFayA37NTliObi/8
         kvPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvA4of67MvyIg8jku7jsm3V0HwihpRYK93Mc19eB9+qk64eGmClfGVc4ROjAjROMl91MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCu1Y51dCJhNXJSIEXaSYDrnXWDRK1Ou4b2AvhIHH+RY758Njt
	L+Fv8I+yP3UuLdwmoTk19E1ly0Ragf0YKRfKMvkTPmKwiNS8q2j/31BuzOkFLBkWilUHvVjUbdv
	ercSoW3J8WChVCZXMsuaw8p/3jIRJwZJMmcNzqcyRrEK6YX3BD+nVLg==
X-Gm-Gg: AfdE7cnlXMbion8PR/ji9JZ5IyNDLYtFyNhgoCfLMx2+BFQr9NJ5g8oNLE01AW0DvLP
	xLdQjnpR1Fg+3TJZOPJPW65wC1P65hm79Osynt+WF16hWj30ipA6N5SR9t/agR6fBpvFKkvoRqd
	p0y5Q5geTvbR0EPihHW3TiwptBhUEOzTz7urGhanOsxdVFse/RdsXk5GZbfwZOjhOMUlF8uCqEC
	kCqoFetlPi7JTDHe9oMTp2lE/c2lK3VJfLrMMmVqIF7Pwfztu5opkYUQzFkSqWR9OYq7Jm96wNm
	tjc43a8yDGt44IzX8xcaq2SqWL06hfKYWcRMeIik8gkymD8RiCr25sE4Xda69zhgyYyqJWAcESn
	OIB6MBBWvc2j25quYQEMfFcaiIRc16vdCIFpZtcVGYnz6s0tkQVdjnzcB81y6qVHovJVkV2x5Sr
	SAjMCIIBGWzKykuA==
X-Received: by 2002:a05:600d:84ca:20b0:493:c984:db9c with SMTP id 5b1f17b1804b1-495389ce041mr53836375e9.2.1784126592969;
        Wed, 15 Jul 2026 07:43:12 -0700 (PDT)
X-Received: by 2002:a05:600d:84ca:20b0:493:c984:db9c with SMTP id 5b1f17b1804b1-495389ce041mr53836065e9.2.1784126592437;
        Wed, 15 Jul 2026 07:43:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464bbb0esm17089575f8f.28.2026.07.15.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:43:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 00/19] KVM: apply chainsaw to struct kvm_mmu
Date: Wed, 15 Jul 2026 16:43:08 +0200
Message-ID: <20260715144308.331055-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624213102.71082-1-pbonzini@redhat.com>
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

