Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A261A285
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673807; cv=none; b=lLPNfodpnpyuxJOVxuXhZr/6QpKumr08KDRP0873DsqOJ3ZBIOpcKHGvy6/9nZcwordlMUHqY5Hgj35ncejghBoCPT9ViZCH3ROBUklFnALf96dbUb1CzPZXBYd6bQWfWfKyhCw/qba2ZFJZ7P4YoPg8kRt5E6Xcl4HhW2mIqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673807; c=relaxed/simple;
	bh=qlPS0sqMCSOO/GsZqCZjJyLYIRd67O340a8OE0Kzar0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOq2Va/jnBSdWfemFimIWLzMWj0Qg8aOhOTM+KP+J/4P70okNj63bSZm5G6E3r00H2L5p9BCrgHlefcRJbXXkELHIPUR1cOADsttI2qzTbZNMYK7/Qr9r0elVP4S8X2SkzQL5Em8r28U5Awkrysz51dJiArFcgc8trPysGzhp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjeFJdTv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjeFJdTv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so27882f8f.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775673805; x=1776278605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7qCTe6ED6FCLce6ISHALUAEngEdutUkIqM/6TQUcGs=;
        b=sjeFJdTvLVWQIHgInPnNtNvfyop3ieE19tiBxVdNe8GTqPWs3aMONzanYZEy8a0YnB
         SpceoQiSEvxKeLngIjD+/KDQ8+4aGbtWHWzvXUrJM6N/jUAKNv+F/ZEenHW6pZSYQnr2
         UJa38ElkCtaOKN3Yd6cIl3Gd8U0B4+YW5VV6OBoNHa6XKaJrAd6z0ChabW7xRv8mZASY
         rUXjuuWVhn/mSqBOpjQqdCJNhwN0kW0ghGCHGJS8B5YgPxRgRF7sT2uKDHdT1M1Z8rgz
         zK7lsfkl/GF1KoN0kF4bL3vv24m/ev4JDMLM6Lkdvzu00R0tZboS5QRfU2Eh8JV0R/yz
         qoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673805; x=1776278605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7qCTe6ED6FCLce6ISHALUAEngEdutUkIqM/6TQUcGs=;
        b=kHllcAf6N8pqwdijgsuUtxx+k1E0QsJglJlkgTvpXWUP+m3qZze4Ot+JwRs5y0W2Nn
         rzw1PoKZ/rRRfPebl83igA0YD6fqRL1ucQme3ZkWI+fZHsETt4w3IT06+Lo/AmXIxILw
         0Gdgy3ywUVCx//yFKQJXI2+efcrdpjZNbSbwHsTHg6jnUqxZWJ5dfp6xr9mcqz8I+828
         ItNM6pqWhy3v86TG1BtphlwlZhiiI2E47V1rSjJqRyDsEFu7btZL1tJ9mr3q1CGDllPY
         qEjrewHCPTTakVYS68NrUXrC2dljSgKCnYULHheIU2a8zDD5VhW1SE/475xMIyKxwe+H
         /pZQ==
X-Gm-Message-State: AOJu0Yx9HGptv+TJXO5EXws66V/eLWUMyK9CMcY7gOB6XkTXt7NuVn3D
	n+jPtFA7U/Mpvhjmw3b1dtH9LGoJu0990XszFJBUfj/cb8IbR3bi472d
X-Gm-Gg: AeBDiethf9nBIliVbEgGxy6bO/e4JnZp6jE0oua26WbZiHiWIq7BbPiWmx1iRewKVTf
	8XZofYdAk8o2iYlqTCoDkykHM9zRtj2JoiLtxUAS3qOJscAoJZJI+A6ox7nrmPQjyisgHpd0gJv
	gwcz5K5IBxm/5DbK7KsyXIppohNT80P6tuWEOjEl6ZWGYaojuzcAvdTlxpp149tBpItGFeCOldX
	QgUqPmvSnGALBmLsbKki8SFOswJKJ6aMxcOmzeZslloTwl3ueOjsknhwz4VY88VWTSVcAsaa2jj
	6RmBAEEoywChqfFMzykcdtzlgBf+UYtbrVyclOTHDPCMhDzbY/oreCyyqQC+KcwmmraJZFi2oLS
	Nka92Mueu140CKb3qgBpJ/VBBcN76ES2O1SQpvpfXpkLxtKCUp6iRGX70HU0r96bg9iqxLbl6Ih
	+z28Uu3ecDyhyl0TngMA==
X-Received: by 2002:a05:6000:2586:b0:43c:f8ee:c630 with SMTP id ffacd0b85a97d-43d292db10emr31511798f8f.35.1775673804442;
        Wed, 08 Apr 2026 11:43:24 -0700 (PDT)
Received: from nuna ([154.160.21.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm61267589f8f.4.2026.04.08.11.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:43:24 -0700 (PDT)
From: punixcorn <ohyunwoods663@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	punixcorn <ohyunwoods663@gmail.com>
Subject: Re: [BUG] KVM: NULL pointer dereference in kvm_tdp_mmu_map under memory pressure
Date: Wed,  8 Apr 2026 18:43:32 +0000
Message-ID: <20260408184332.187482-1-ohyunwoods663@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <202604081633.sean.christopherson@intel.com>
References: <202604081633.sean.christopherson@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To be honest, it could be days. The original crash happened only once 
in a month of heavy use, though my system has been hitting 100% RAM 
usage frequently. 

I suspect a specific transition-like a guest memory zap during high 
host contention-is the trigger. I am currently trying to reproduce 
this by scripting a loop that reloads the guest project (Android emulator)
while the host is under heavy memory load, as that was the environment 
when the crash occurred.

I’ll keep the current debug patch running. If I can't catch it within 
the next 48 hours, I’d be very interested in that more elaborate 
debug patch you mentioned to help track the SPTE lifecycle more 
closely.

Signed-off-by: punixcorn <ohyunwoods663@gmail.com>
