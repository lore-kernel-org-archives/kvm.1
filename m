Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FA3ADB9B
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618949; cv=none; b=qcpJEn1yjP9mRRVjdEm2H8ndtyLLdCVLWJt3yb41nqI6oVSmGdFBvPep5tofFLgxWFXD8PlWgUFHXGH81HfZySP3xX93moU0pi08ePbkFoEofUtZomvRXNrCiS4idJxfGELJC/A2Q0T1nCgvC7S9XGEtTvFY3UxL8vQWKcEr07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618949; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP7cqzGGYiSvBk7xUtayzZw4XR0+62XnVH7uBWQ6lwtj57L1K45HaoE6ZkpBg1WNGHxlWZExZaxeNeDECNczsDloHKKG6vNAfjZCzLoht0Em+hdCF66X+6mM8ElwRPq5CeDTAxRJGFMVDdwy7t2XO4gUctg7CluP6VsOYrq1MKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkWSXMu0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PggxK9PA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkWSXMu0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PggxK9PA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778618946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=WkWSXMu0t0Q2Rbdwqksj1CtvV6WQJVd3s+gICdic2yjc37v38UuUt7HPTExzqKitBrNTKB
	BgxbSc+L52I/t0ESQf7bUEt50zzZ+yy9EpBUvdcI+WXFO0rFDDh5EvlbS8s1WhmTMlpGBi
	FlYmm12M6Xe22Zi/I+5e4e1dsTfbCoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-CjAgetuZOeaChE5OcsCiqg-1; Tue, 12 May 2026 16:49:05 -0400
X-MC-Unique: CjAgetuZOeaChE5OcsCiqg-1
X-Mimecast-MFC-AGG-ID: CjAgetuZOeaChE5OcsCiqg_1778618944
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4497a0e3acaso5473758f8f.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778618943; x=1779223743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=PggxK9PAIEzvO/eRMYRniR/fVZpVvi3qNJbcCITkhfgJXrxFKwsT6OXM7RIByxPBRM
         47eE/M6O44X1+gfyx0zz9mS0s5ZvAAaoGeeOSnia3+L31XpWozI7JgSSlYtwf8v1No0B
         PyuiHe3jjjEWNw+Lzl6vhakQCsyTnX3y+qW4lkogO9J4K/mmO7UNI3hOUBMsBlTCwgbe
         qpQLyD/po9ur5mbJS6/vjoG10p6dO7jE7kLuJWiq2kNhchm1LKng7x2j04/HjgOkmweD
         NAXGCTuiQKAVFyUTNq9x5kTSCEunorRb3X92aqNBQiSG1n9srit8ZkreUQ+Czl/UxLkd
         PzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618943; x=1779223743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=Nz1/h9bagyMQdSe7sRMQ8nqNHCMM1XW4/E7/QhjHRe+3jGOQTujxcDaCYR2N5tSmo9
         c5WOnbYbG1+PHF7KLzOAtv4MMlClbxlfnqOVI+vpXBtKgRCRcGYDuwXbxgileQ52H7n5
         KtZQYYDs6AgNxWna9D2MyI8Lj2O6bdmxEXYZKX3DxHRHTabDh/RIQv/b0uavdxD7Pec/
         C+gqDq6YbFYrEukTnA6gHgbeURrvtYw0Vk/bfNmenZT8eocPxE9eD19EXhziqUO70mvL
         Zdb6HC1v3yR6QWhpV9oO5C04IK9bW/iSZ7hWO7sBrhJD7gpMQgGYDEsljUfbgIvA1W+5
         v/kg==
X-Gm-Message-State: AOJu0YxEuRk1BwNjI7SofNsoe3ENWMwC4Wfb7g4OnG1PpVyxkdh6d+tx
	DcNPaXgrMxudPx6Ow7ls17WItnczzQXemQe6Bm5LtscKF0WuIphygHNSb9yvjyCVcWNz6s6Si7m
	0/XvTppXs1wdPVU7cuM5UVrhc6/2GOLe/X/5C5WkijDrsEk4VPmbJIBdDQZQuDQ==
X-Gm-Gg: Acq92OHFJl/PJvInqviRld1KWBUQb5YtWgV5CDbn6GgWqtSvjuC+oAOTl9CyRtOQbBj
	5IjJdVno0tGYgT/1EmBwhsgsqHIaA09bnFeiW8JONFPS1mgDoI4AbAeXhG/pX7h9cpZWZmgtrAA
	JYk4HZLvdJOSNPOc3ipICOWV9grNDBAvgyCRm/p4nzk1AiOhGFBdoLlDjmeedLucx7YkDM+4TlD
	3CoO7vmb98mf2L1aKmc60ZOQAbAl/xDFK3CbUg61kexc9Oj03Srz6eIe6hWReqzdcJ0L4hgGr52
	iUDOXLzeKFpaGzYbaAtxPagrm6u9c+LLO6W9sFMIzc4rfHxqjkjgIdw2RgsvvhRrAyyLusSE5Lr
	lc1T7tkyb3N8ihkrUsbCdT/YXNiFo59IvtrkeepcXQHhj5aEx/UeYwQ0vMfLEVRMnzLchO3PvIV
	zPsJlynTzHCOag7Z8zCnG9WfY0qGaQ
X-Received: by 2002:a05:6000:2310:b0:456:f186:7af8 with SMTP id ffacd0b85a97d-45c57ededb1mr447224f8f.4.1778618942729;
        Tue, 12 May 2026 13:49:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2310:b0:456:f186:7af8 with SMTP id ffacd0b85a97d-45c57ededb1mr447196f8f.4.1778618942313;
        Tue, 12 May 2026 13:49:02 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120f1f9sm35458295f8f.24.2026.05.12.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:49:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Eads <josheads@google.com>
Subject: Re: [PATCH v2] KVM: x86: Swap the dst and src operand for MOVNTDQA
Date: Tue, 12 May 2026 22:48:59 +0200
Message-ID: <20260512204859.3035082-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506213514.2781948-1-seanjc@google.com>
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

