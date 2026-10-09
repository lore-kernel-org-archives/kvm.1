Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF78471D16
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529896; cv=none; b=l/gFbLewtOzYsahMMGH6hiCcJ64ytYQggmed+AXUZNEXoaWi7bVCBU2gTAHsdBUk0k8TYFwAgYrtDgw1fgzxwf7F5Cq3MdKVu8fXluZw0i/N+zgmkNWcxfw494eHdwQC5jHmK60ELQPK8kQ39HfOnixhl0mUBP1Md4O3GBzcns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529896; c=relaxed/simple;
	bh=+3BT92sWytCvb3pLA/EXvyVT90nOy1CuxYDMO7Gq48Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/XWYV9tDsk2fgXETbsvhJ0OdC3Ub9OAU3olTgks3xjLQzTFpsp7DYnQUQd1NFxziJfgyPSzU/pr6HEtix/V/iZrveXClwPBRmrmWON9pCFDP0XXenn4VJc+3XY+ViJXDn40Pbk4EuDwoUrFGJeOEZ2EPg+/zVJhRcnbRTc/ysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nWvLvEmd; arc=none smtp.client-ip=91.218.175.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nWvLvEmd"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+3BT92sWytCvb3pLA/EXvyVT90nOy1CuxYDMO7Gq48Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791529892; v=1; x=1792134692;
 b=nWvLvEmdbCGjJQALPBGhhlPOS14KCRHXhFjV2rjmUThaS57Tkej7/4ejU3uD1O4s22G1jm+/
 +CCZqQpuyppf5OaifhXRys0qnt93G4OF6TncddMuCprwruJrEmWKchfnX3VTU6DWYq4irmeuJ+D
 95LWs513Wr8q2tSjswJw0fxY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3b2c9473778fdbb;
	Fri, 09 Oct 2026 07:11:32 +0000
X-Mizu-Trace-ID: b3b2c9473778fdbb
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so5843e87.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 00:11:32 -0700 (PDT)
X-Gm-Message-State: AFq9FYLj3zSLKQycyWEAZJgK/SaifGkwHW8SbUrCKQAILwqZwejcTTyX
	9ldZCv0l8F4ZCVF1R51DoBn00wM1DVhrwVDSp46XxoQtTJzfjsOSt4r/n21U84p+0EEIFGWeDHi
	XXwaOUYSRVLQBPQeJzjuPuh8GZJckehnwuZq9YFHV
X-Received: by 2002:a05:6512:1194:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5bcdf948dc0mr43820e87.9.1791529891928; Fri, 09 Oct 2026
 00:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831192406.1341841-1-fuad.tabba@linux.dev>
In-Reply-To: <20260831192406.1341841-1-fuad.tabba@linux.dev>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 9 Oct 2026 08:10:55 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwBXEVp_fJp+SvXqrfab2NGdnCXy6L9n=aW2yeTUUOniQ@mail.gmail.com>
X-Gm-Features: AclHuK9OgMQfIJ6sfKoLoA9wmDjNzBE48OI8X_B1wQUZOUjYO1IsWkWO-9TV2hY
Message-ID: <CA+EHjTwBXEVp_fJp+SvXqrfab2NGdnCXy6L9n=aW2yeTUUOniQ@mail.gmail.com>
Subject: Re: [PATCH kvmtool 0/5] Fix diagnostics and capability probes for
 protected VMs
To: kvm@vger.kernel.org
Cc: kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Andre Przywara <andre.przywara@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Will,

Gentle ping on this series. Marc has merged the pKVM core series into
kvmarm/next, including the KVM_GET_ONE_REG -EPERM that patch 1
handles, and all five patches have Suzuki's Reviewed-by.

Cheers,
/fuad
