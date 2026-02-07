Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E553256C84
	for <kvm@vger.kernel.org>; Sat,  7 Feb 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770471516; cv=none; b=jT9h7Krb29U+6VRscUK3U+QGRIEKUlV0tYCn1hNSes7k+Gx6TNQXSB43NtvYP35SCjdr+z+rgl/RLrnZcGItgTmiHvJmH5vG/potfUIK/DgU7E4El0CAU/zRcDkXBg2Gh0AQ827hB2l2c0vduUBb8VsD6DzRr21no1smd5/Sg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770471516; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzHSljva6Y5h9bxgygrD7eo3JsZPZku783OiMdhUwYcfJ81eST/scIsNIbLgHkZPJ8TM3O9vmXx9TmtvVAh1t2VUS/YzsJ4s82C0YfNN61n14LU57hzEEPty4qEyh9QWG61v0aGEpC17HN0DrD1ckA8g+35Bx2QerePVpbnIea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqUid5UZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LS2o5LKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqUid5UZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LS2o5LKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770471515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=SqUid5UZB4dkqnt06GgPgyZdpXIOR1clk8xlSdUp+8Aip9hSPds3cs8hjnmMAzGLCWcrGo
	5WIGg9Y7F5j+Hz/shIjqs/QvesGWM+F8ErzgiHdSgR5T46ctuAKOHDK83DPW7NHjNb64Bk
	WEViNNOLn4yv5jfj1+p0DqHHpXOI0J0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-s-1AY7n6M6GuC1L_0t1giA-1; Sat, 07 Feb 2026 08:38:34 -0500
X-MC-Unique: s-1AY7n6M6GuC1L_0t1giA-1
X-Mimecast-MFC-AGG-ID: s-1AY7n6M6GuC1L_0t1giA_1770471513
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4363333c102so318294f8f.1
        for <kvm@vger.kernel.org>; Sat, 07 Feb 2026 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770471513; x=1771076313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=LS2o5LKDvrIIa4xwYvRPrjDpGDQcVIM+0Rzeru4oTegK6j6AY7fFCfMA9gpTz+Hhzl
         jZNuvGH5x1kEQfd2q8GoduArpWeBez6yKDsa+eGub8pa5pMfmFydbbLq6pIOSTcpXsV6
         lL+jTbZEqdFoXbcJ7Z0JSZhyxicsPOVC4zhzKHhhz13sCP1IHzVFT+utmzKKAx5o7JSK
         e+yIju33gG5taU9NNqNMFa+2oc1sowcP39ggS4v3H4SA0sSra8z3rHJxQSdCz5cbMr8A
         aEr0a9xjWLbJyMM0fCsDFiUhSEE7WMg4pAEyxqNGw7yIauxJ1nNZZNhu6W799W7MV96r
         fCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770471513; x=1771076313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=kRUHGZHNoPSgQwYStZZQvNe9hh4GHdVwm+t1cMjpNqb39o9xcDkCmjG+DVNOOigfaR
         JwjxQJg0JQ8VWpgwuLhmezsBvylE5ntFi7arSMU8V9xbPk1ZYDn+EpcQZfxqyx9qy3c7
         JomgNQ+r9rxlaXpMMYZCD7AYATXh9SrK5oyx+HDjQ2xgKGX69+WFhI1nlBzax4+KfmVf
         AfeULOx28I/9z6A86QN/sJugW3yg2w8fvbd+34t5tykwYgP4K/Wl5b1cLAP/VZzeT6V5
         YUPY/2Vm1u8H/OjDQeZ2KCfMIUjPEZKQa5zAtwQ++Dz3yUzOfJMGjUbjiR42bb4Uv7Vh
         0/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNu5r6DTQdQqlsgm/WFKBJlT1Ad2B/6NcIH5/DlUqk0nXXqzR1WxyHI6VXfS5dkMPYfPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwBvuqSj8ODkqnz/UqYqQuh7whFlV6bvwjXdc7XfG7nLoE+WK
	aLUUrJKpUGPRSVPud6pDt75FP6kot47RvUca2jugk/m9yNLDIEqr5XGDpX0nbAKwqjNsbyqX0LH
	e104ar2fQsSsz023rpdVf1Y3a0Ignzm+H1cXcwmITogZ2CojSfR8L1A==
X-Gm-Gg: AZuq6aLa72Ub/mijD9bagfSAN+jdtb55SwowHuCxY+pTbalcaBw45NXnWpo+wvCWg9D
	UQ+i5pi5glVVub147R0KTNhxpMKVoNrEon5EWXv97c4LQb+YLTAikFXZgnTnXc2uN6bPB3kRr0Z
	KVfJ5QREGuAZxkhTYar2J3QaH7N3ZcTJ69I1B8aObXuZxds7sBIkVufVSMvAEgXNIP0o14qHFFG
	AaqvWHECb6IKogZEvulMG/FXLSbtk2yVHxCFoCoblChOuQ5ILeX5QrWmG7rVbJZkbeivyckqr0m
	B4rOqXs5wcbYTs0wWWPn6Oz3PgdProPsfR+IVMbeuPOqWRMUVXkDHE5rRzBc5en6JvGfw6fjFGT
	ix/ns3PJfXnV1+jqGxYbT6dBRs7oMYmlL5Aa4S1BfEz1FBgGM/uro+hQTpMobO6NGeHzsvwaQ5A
	9eVwLCkBtVOSF9+qVmtzo9rURb4QUOfFzUm47cYQJwMw==
X-Received: by 2002:a05:6000:2c02:b0:435:e520:d1d7 with SMTP id ffacd0b85a97d-43629386511mr9608400f8f.63.1770471512729;
        Sat, 07 Feb 2026 05:38:32 -0800 (PST)
X-Received: by 2002:a05:6000:2c02:b0:435:e520:d1d7 with SMTP id ffacd0b85a97d-43629386511mr9608365f8f.63.1770471512319;
        Sat, 07 Feb 2026 05:38:32 -0800 (PST)
Received: from [10.58.49.123] (93-44-32-35.ip95.fastwebnet.it. [93.44.32.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756bc3sm12193306f8f.39.2026.02.07.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 05:38:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org,
	devel@lists.libvirt.org,
	kvm@vger.kernel.org,
	qemu-riscv@nongnu.org,
	qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Sergio Lopez <slp@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Laurent Vivier <lvivier@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Amit Shah <amit@kernel.org>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	Helge Deller <deller@gmx.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	BALATON Zoltan <balaton@eik.bme.hu>,
	Peter Krempa <pkrempa@redhat.com>,
	Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v6 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
Date: Sat,  7 Feb 2026 14:38:01 +0100
Message-ID: <20260207133801.628488-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108033051.777361-1-zhao1.liu@intel.com>
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

