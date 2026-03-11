Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467740DFCE
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245308; cv=none; b=cAacongDQ2vitPoi9Rw2MizrCKXMKupPPtSK4UXDo3olnzL0WJesfwCHvkepdnbDcTObJqPRpicD1ZtnpKt6NVKhgF5wweCGTsdl4l2Nv0qVGlvjmBuqBF8XbhejUIGW4jwoIgRRV9CW5KaN1O2rnXeRVrMheVb846ptq7ynTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245308; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llggdqy5VXSuo++BpSgosieWj276xIZSHZJ2mGRzAefgRjQ+jWGAaZ8jXEyONizAWk9grI+CXssd2bO4mD8y3LrcSe5hkS9ds67xKGqjWw86gqM2WfwLSLsNwRagkqREF+2amvGVTC3N8EhDxCr1W55YEEOpK6B0M09H2OXsULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwI1VTGV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDG5Y59g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwI1VTGV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDG5Y59g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773245305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=hwI1VTGVxCNqmxCL9FBfO63f5wfJOKtiGcdnVeDz0Qa1ot8wLvYuxwalM8yEfiqZ4iyIIP
	Gwidamviym1TzidIlaSqplXKIdf1XWTyWsgAqebZMF7HCclpaaOzaFN2+SfL30Fdf2exvQ
	ZnHO4iIhj2OB541qQbK5kj39YPRdO8s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-9qTaooHpMGm_peK2l4AebA-1; Wed, 11 Mar 2026 12:08:24 -0400
X-MC-Unique: 9qTaooHpMGm_peK2l4AebA-1
X-Mimecast-MFC-AGG-ID: 9qTaooHpMGm_peK2l4AebA_1773245303
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439b50dfca1so43562f8f.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773245303; x=1773850103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=dDG5Y59gJdtW0ImT5X5hKHzPzQJkuRKDe+314KhQjVaOQCeauLr1JvhsB1NhmCjNF1
         N8kz/zvn67tAaM+tz34rb/OYY1B5GZDutALwoe0yQg6MdF6GwAMblNN2cMZztH5pT7zW
         K/mbpWRXfJbsqMWDRIuhKndpgFgXmWpjCpawYADS+vG760/JOSkA/1muWC0I+1T1DZnj
         oPjuvEyk1O70yhCT94Cz7xFamTiKbmdIrCpuO2HAwsYY0wD2xC6b+FlMcalyYK3T3H1R
         IaPqhSEjZdQP8HW0gq8OflsZSMoRHFGepiRbHNPr8Tey7Nca6t8uXMXBdsc5EO4nALcV
         11Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245303; x=1773850103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=cm6C47To3NOvx+0vUJ2rHX+5ji7MpnD6NepFBdBIcwCpQ7FUv9q0ifFbMQHv4IOUks
         v5yR4fTCDOip23vtUPMYAB52NFRHloyiRnpdxUXSOn+e6HXrOFSB0mz0290EppFiNmxR
         9YjAaJwlPu+UrqqWnATNSjSW+88V0x142l3Yh/GrNOoB4uW2X2RF/YTXO3R3tB58ri4n
         0StS1kTalUIQo5iqetg5Wz2dzAI11Cy8QUxTk9lEktQZoo+3yBEYqwvARo36uhiUorMg
         USXTUmq8SJYRxLYWdIyK+/JGWTsHpaaInbM15oEN/2Nceos9m8u5yFRXZeqbX7S8qg9V
         u51g==
X-Forwarded-Encrypted: i=1; AJvYcCUlHbP2mRamtQcxprtZD3gdtzIG0Yb5nZprS5ohukmL3mRUA5Ag+cDi9jRW63N+x/soREs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBA8dRn8jXV22THZZRY3LatXQyOkONh3qTtz6n6iG6oNOtC43
	mAcJejmDi7iLhLVngsZ91pHx384CRhjd9ydFNexHN/VBwBSPsgBfStnsEPPnQKwGVRXmP7YkQ36
	uYm1zr/kj6TDHiWZcK5DDO0xH/4d83kxDU7HkDqO937WzAunRsubBja0i5SuGuw==
X-Gm-Gg: ATEYQzxyRwbr8Weat/QxMnIvjfB+F6s3p5lAvs2pSC/OSDnGZF4Ta1GumS3HP1nHs+W
	LznQCFqOODoBxebWWeOA9ZDaUu9irjQq/t9XvzyaFdCmTMLGLWPbO2fLFebxgBrPZDGUIBk/QY8
	iQXt52ii0HJRh6srKdksU7g4CuvyygpBWkc4T0pyCjf/VVRg/AK44ONhVIJzlzOVCWMaUyTktwh
	vqzr3MBgJvZaBeCpDBwSpaLR3vzuOe/bc8IuORm6Ul2/AETDtnWVF/4wVN/zO98UTfZy/8uR3wq
	Ff3aSxnq40RKoRaofK4LFvvgI82nweN2JMlawUeYCPo9S2XCYcZYSVQ6LL+yArHFwAUItoLHG7H
	IW9SQPA+3La1DZP9Cv/zXWkRabrdM7LDc+9KgFWpVIOiVwjd7xCSBrYtXwiZWqzYuiD7TQCZCaC
	717i6zoeSjvqQxTI4RBipvaJax8tM=
X-Received: by 2002:a05:6000:26c9:b0:439:b59e:5e6a with SMTP id ffacd0b85a97d-439f8204ad6mr6007655f8f.14.1773245302750;
        Wed, 11 Mar 2026 09:08:22 -0700 (PDT)
X-Received: by 2002:a05:6000:26c9:b0:439:b59e:5e6a with SMTP id ffacd0b85a97d-439f8204ad6mr6007585f8f.14.1773245302219;
        Wed, 11 Mar 2026 09:08:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm232987f8f.4.2026.03.11.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:08:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
Date: Wed, 11 Mar 2026 17:08:19 +0100
Message-ID: <20260311160819.555999-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311095405.26297-1-hi@alyssa.is>
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

