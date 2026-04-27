Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BA39B489
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278232; cv=none; b=BvmHq71BxqRz6PZbYhPNt2zSjjKQwvnhu3IuAuUNKPc0Bwx/2VQpYl+vs8GuKzRbFuXC5DOpswiaw4E0dNDi2+hvCRXEyE+CQHgfJb1bqXzG8VAElpCzOtsYDO6sTn4w4pbKLho+QCWW358F94pvXqeO8u43pmKCCFSjfOfCtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278232; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRTol7skZXcV1kMq7emGh2idgQ0DfvJxmol6dyq+KlQ+QZT4pl8fx9Q1/W5izob2o9HaTIIzYEMPjK0JGPnFavb6LbBzyMgafawyRYAcBMlUAl+U9fuDTsthu0Iy/+XoY3bdVoQHmNkNfDjGL4z38KyLkqOkV1d+aUTUeUiDCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZC+Rrlm4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZC+Rrlm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777278230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=ZC+Rrlm424ves5ngn1qPr+P76ecxUCg3dwp+ot8KWugVN7+bTPosDYBl0+Vf/LiE21+Gzb
	0fkPu2pWCUoK34yDTMeEiRgLQ6vXBV+hquydtRUcpsXjkLVUDFgU4VN5FnWRcYp4kZ72XA
	Nwerq32jalyBEQ2ybcDF1b+4cpt6NlA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-Jnka7EGIMvCY0bnFD_6hww-1; Mon,
 27 Apr 2026 04:23:44 -0400
X-MC-Unique: Jnka7EGIMvCY0bnFD_6hww-1
X-Mimecast-MFC-AGG-ID: Jnka7EGIMvCY0bnFD_6hww_1777278222
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 882C31955F54;
	Mon, 27 Apr 2026 08:23:41 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69C9E195608E;
	Mon, 27 Apr 2026 08:23:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Anup Patel <anup@brainfault.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH] KVM: selftests: Add check_steal_time_uapi() implementation for LoongArch
Date: Mon, 27 Apr 2026 04:23:32 -0400
Message-ID: <20260427082332.35273-1-pbonzini@redhat.com>
In-Reply-To: <20260420192644.3892050-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Queued, thanks.

Paolo


