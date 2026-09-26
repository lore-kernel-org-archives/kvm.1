Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F7386C0A
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397464; cv=none; b=FfWge4EYUpBGR76fDtAqJr3bzHWIm24C9H9WmwabvqFJbFhTTn0t4PCE1OvotviXsbwE7h4IPb32/Mo9PExUNCpL0/dZwTx48kqj1+Jo8bNjqBb9SSJEpviKi1i9+ZVfRELlubuojKn3Tq7c9JDkmO17hvMRmuuFFxDXD3qHG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397464; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie970BMvMwpTrTzmeuiLBsNcmShPEpOdlZNhsmCuE9w0WpIURnimTrg5iV25Z7R6RH/XD/K/6MeTgnbYBdqh6WYrcfoxly5sTHcagss1WKFa6LG0xfTDhla0l2jRYGZreGXalekaWBNR6YKeN716hf2WTN4FMgntXB7+rd1J8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSg4fCos; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSg4fCos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790397462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=YSg4fCos52CJXdImq4+dXD4Y4cgsQ1OtNFxmEMowXh34uM4Bnm7uyfB1m08dyT1MtgTvYU
	/5gL/F+ZmIDS3lD7oQZ7bcpk9UCHzsDyHtzRIZXe/VTHDlebcw1aUNyANutWAXZLwqLZ1O
	UW2Pq5T0zWAdJ/qDKTWApynajbJyL3U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Z3RUTcuEOXe1-f9hmLnMSg-1; Sat,
 26 Sep 2026 00:37:37 -0400
X-MC-Unique: Z3RUTcuEOXe1-f9hmLnMSg-1
X-Mimecast-MFC-AGG-ID: Z3RUTcuEOXe1-f9hmLnMSg_1790397455
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5853319541B2;
	Sat, 26 Sep 2026 04:37:35 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFF0330001BE;
	Sat, 26 Sep 2026 04:37:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: Re: [PATCH 0/2] KVM: SEV: Fix intra-host migration cache bugs
Date: Sat, 26 Sep 2026 00:37:33 -0400
Message-ID: <20260926043733.187620-1-pbonzini@redhat.com>
In-Reply-To: <20260923163721.1584779-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Queued, thanks.

Paolo


