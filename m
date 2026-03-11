Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790193E0243
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245258; cv=none; b=Da/DNQmGGjJLayxfzyYc6VcFK3hUcrGyMOfjBBjoMY6OJjl6B5eooZWO3FdDqzQXgL8uoDf3xsGbvK+vEe7peeiU+vZcd+vn4X9hn//PWbR4/yVQsWIlRh66LITdxdFcm8YdYWrEXWD3ffJfDa3eayynoHr7ayVAuKemOpZ9W48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245258; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6j7R6Skd2ILk0WqewRx0hwVCfpPL2MyW0eRVVR7BGhMGLLIkNTzrtVwy8smQ8lFNIdQV3QHei2P9bkxD56ixWNjpjFXx0rYao7tOlELAwx+l1v4ndOMQnNT2+sz3vIou2rHJKnElUXy8AKKIFbb+AX5+R3Shf4FW70V0xilt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiDuCEW1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7dZLBJH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiDuCEW1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7dZLBJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773245254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=IiDuCEW1S5v88qKgMZ8szQKhbt/WfyhJqpuf0RgNMuOaBRDa0VORLkzq9c22QfUOs8qc2B
	ylQUa9BUzrjWiywXbyEJc3tRtWt1zhe4uVgBZ6gdNqWr5T8gn9k+HUW7rLp87DDThENa7X
	AMHxTH3bE6lUiP21jR2K0Xgf0zAwuao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-KJDrcQ5PPBurszK2o7lR6g-1; Wed, 11 Mar 2026 12:07:32 -0400
X-MC-Unique: KJDrcQ5PPBurszK2o7lR6g-1
X-Mimecast-MFC-AGG-ID: KJDrcQ5PPBurszK2o7lR6g_1773245252
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439ca4b3d0bso21184f8f.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773245251; x=1773850051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=D7dZLBJH9h3KzbEUSP48oHFAv/vSnw4Md6qsrKkl+8RstYQB4SRZhHoAJi+tcixDF1
         +aTvvpbayYqkH/qpT352RNLC5Prdrd2TVr43Fib2f7KT7xKwbqSyLIFp/rNFwPI3MfSa
         zMoXFN0cyqPBIOs8bq5fgP7UERXEhq9X5nvWd8cYIr7qJ0cskgxGmi8eSAiku+OH3gbY
         FwzaZ8f13dHoPNRuJAs8KBskCOywivWBZWLzaLplBsbWXAROoO8sbGkufSWjh3CWhiBT
         1/Nvf3Lev+Wx5wePo0kIQuDvXJDvfIWmHTHvHpc7UrCG46zURdcs2tcaFN9NHqtClkb/
         ucgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245251; x=1773850051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=JQAxTURenksP1q/rD3mwRiNFySmVwdLf8AGV7AnK2EsDghd6Y8sf9O5m9FkUm5bAsh
         yqIZFjcsc/2jGB3UnPhIvL49r3fC9q4b+hLqdyVOeT3mIiimqEffc9w5p3Ysm4mDwUoo
         iQNzZzEgdGqhu3rx9enH1K0HKLBaRQdD5JL+hoxApfmUJoXNPYggHEyNFI3ZSdjKq4iw
         VwQ2AfMDXi1+QRt6jAHV0CxdunMxMrZCzCaSnQl+XLDcSoL//UUTE6VVIxB0PrLrO1OC
         9icdpOniGw0VoWvX4YVFMFKZ79xWCbPvfvkZSSjdjhhrKhaQVlnHWNt/yn27veC/UxjK
         Uqvw==
X-Gm-Message-State: AOJu0Yz0H3wYU5dK2Rv7VN3q+6bVIv0KKjfpxNGJDUmE4p1Ru8TFrOe2
	8IHv+Mm7cjPE0MY1JEPHHPZVWRDEWvenqf5gZ90idbz/yzpNu9FtApNVSbljFOlsbIazmiK98QR
	wT/an7IpMjrc/7LqSojynDuWAsUjfuptN5DRbN3YDz7mB9tXPP20rFKvozVcOtQ==
X-Gm-Gg: ATEYQzyoYsuk39IVhapLKrSBuJ4oa6xgkhm5IkinP9tHk6PmUE2HsCe1MTbV4rDdlZo
	kqjU7zRgpwSd3kIQJab6SIK9gnTyRK/sdiFTDbeYmxDtmt6G4OdTIS+g41MMeNAJrV5r2e3E5vc
	j4/RN35TPw6RvvNVCdIjxPGwPtJnYQIBCOJzNcwL1VcUSqmM6Kp3U5OY558uVsa/rPG/Kh5CQGb
	p2ecvdVmfs4Rg+ZiwNj42NPcdgpLRe89kh9d1ElDZ1mcQFxOt76Z6Vl5HgM8Cw/Mv3tEdreP4z0
	1ert/HgGkWBCh8jctQvQ7aR2ioI9HXwb60if6imPBy9zCSxSFdBVO219VurPHXMqy3TaTpz4nO/
	2pTXJB6nEJOGZFy7CbaPT4VBMfdem+wshFI5qrhA4M4K4+s4NyPjoO2+cUkHBPnOtVddgdwXUGu
	61UiteqWRqSUrG87kQ7k+NOpetUUM=
X-Received: by 2002:a05:600c:1c29:b0:485:3f41:e113 with SMTP id 5b1f17b1804b1-4854b0ac248mr61254935e9.1.1773245251152;
        Wed, 11 Mar 2026 09:07:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:485:3f41:e113 with SMTP id 5b1f17b1804b1-4854b0ac248mr61254285e9.1.1773245250721;
        Wed, 11 Mar 2026 09:07:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe219c41sm160081f8f.29.2026.03.11.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:07:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] accel/kvm: fix typo in variable name
Date: Wed, 11 Mar 2026 17:07:28 +0100
Message-ID: <20260311160728.555402-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311095315.25013-1-hi@alyssa.is>
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

