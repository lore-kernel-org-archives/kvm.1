Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143B139D0A
	for <kvm@vger.kernel.org>; Mon, 16 Jun 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067915; cv=none; b=QKwnsfPtiq7IOu/LsUtsW3qFJ+swOat9/2Q6JaOzsfcnBcD8Hjf9dLBLnh/AzPBWqNt4jSzMdmcUBKs+bGhPxDtYeJ+kYh5cAQDw0BBEK11B3fWrnez3a0RVhjED/nW1OAp+fbC/0Y3cLosKWeByUUp3tafaEOLwbDqbj59/RJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067915; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:Date:Message-ID:To:Subject; b=HyOsXHER5DJMAK/5l4UOakOEt7pX+f4/ZonQy2Tw5rK0oCe1nwbfWwrBQmFaL3Qm42RdBreXiXiP5Hvto5vIZbuIYHc9VSxOyJKhnCGF5S58DXMbwk72kiZHtSMMy/1nEPzrKlFyHlEpsRo8YXtcq5JUXO7ApI+W8zwHaaRXGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=gCRMGXmd; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="gCRMGXmd"
Received: from localhost (unknown [IPv6:2001:a61:2ba6:9c01:be22:6f82:7a77:abea])
	by mail.thalheim.io (Postfix) with ESMTPSA id 824F3B94459
	for <kvm@vger.kernel.org>; Mon, 16 Jun 2025 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750067911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=gCRMGXmdJQIx993WMXW76XzwAeIOHCSN2RHQwEIr2rhoUkNHa8pc+99eWrGWFEe6XSbg5B
	i/FQkNB7s4yR5JYqm7dNk/ZIpbWp0FEKiUiv5wkfZQvLjmr5nk2MIf1+m/9duKtduWZRKU
	Yj3vPmWpl/CkwrUg+bEKKnUkHKmruLk=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
From: joerg@thalheim.io
Date: Mon, 16 Jun 2025 11:58:30 +0200
Message-ID: <cddb5274475853e9c08d808abc27169a@thalheim.io>
To: kvm@vger.kernel.org
Subject: unsubscribe
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>


