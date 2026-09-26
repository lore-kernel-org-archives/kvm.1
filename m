Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41E547065
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790399921; cv=none; b=oNLs4y0lpLlpNR93cfszXoHulM7G1xq7ZI+Evdk8SAoaiGX2tLQA6OTnCKzgjlJUcDzhVhsYKFB/4uAuRYJ7+bUgq88MQ2sHnKoBfO4OGWMRqNbpS+EEZ2T3ATcdVN578u4bqF5ktjKpOY0YUydPyK7vdoWh+UJWg8kLIwZ5xSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790399921; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixYNIDLgJeh4Q2IWChuR6DxIKky94T0X8Eu5t2EoMyZONUZwn0zc6hI15LTcU8DSW+CbdpfxbvplwARMPaOb5s83/qNxX43TDJdTUxAMwt7yXX2hrQeAp4mwzwZFh6bgtpQ61n2EsjvMKTTlfQqmCRRgImZqhLhT8CwcLqFuOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hE5slDSV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hE5slDSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790399919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=hE5slDSVc/qrUo6ODZwXtnX9RtMCcAi8DVuN701wwMDSRH5gKPlx4JqH2z0QFhRbbLAiN5
	h+q10kQHhVyj9qidwfcmZljlrNeDmnJwIKRba8WjCm05PQ83aVBbMGlakCUfOzmwIEyxme
	o5UDzJ/wi6oNn0v6xX9YX592l2aGHks=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-j_rOfgzlNsqWzvsOBAFx3Q-1; Sat,
 26 Sep 2026 01:18:30 -0400
X-MC-Unique: j_rOfgzlNsqWzvsOBAFx3Q-1
X-Mimecast-MFC-AGG-ID: j_rOfgzlNsqWzvsOBAFx3Q_1790399908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271711955F29;
	Sat, 26 Sep 2026 05:18:27 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9392180036E;
	Sat, 26 Sep 2026 05:18:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Atish Patra <atish.patra@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jean-Christophe Guillain <jean-christophe@guillain.net>,
	=?UTF-8?q?Pawe=C5=82=20S?= <spawel523@gmail.com>
Subject: Re: [PATCH v2 0/7] KVM: Serialize vCPU creation and revert vcpu_ids tracking
Date: Sat, 26 Sep 2026 01:18:20 -0400
Message-ID: <20260926051820.192707-1-pbonzini@redhat.com>
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Queued, thanks.

Paolo


