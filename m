Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC353BB9F4
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467918; cv=none; b=DYsKpjS+WZDaACOCHVWYgwL9WtDezeoFSPtHQJGlVP4MytwqshxZAQ72yHWYze+/Hz4kFidqQu46QZfHf5p84PPvjuygSXrfKxR3/AvJQv8yo192RscmKRwog7Y6ysQ0tHnAUknri2WJHqvvsCi8FjMxtY6q798m7i7//0m7BWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467918; c=relaxed/simple;
	bh=mYjNeTAuiu3Qu5TnuFkqjDeaxr4tQCJocwXC9X27XCo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O+GSRA62gFmCcaC4UyDt8qt2JRGaVa7CKyAayOpmUFcHW0Sqo4BQ1qOQEsGtP2HyvUgzlfbXo3EldeL+ci3gup/muxHyrKEwuUxpTEDVR8ZprxZ4YxMYPkw0dawSAQdIiY+U64GxLxg7OH2gEQF+UqLIMublAwt3WkWdOGZkhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTnSJX5c; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTnSJX5c"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso84551265ad.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779467915; x=1780072715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lO05kaPnK84omNFj0tV7/7SdlIMyyOgvsJJzRhtWetc=;
        b=kTnSJX5cB6ZXjB6E1Ot1va0LzBiyMGgLwrR1V/mzLFgCgJltArt6Pugrxi/JuKopwF
         wS7n4rAKg/SVqEwX418V+CToRunlGVHfdNtdIK1g/5TkXrFyTKimI8u3VPF9bTgXX/Wq
         x18OamKn+eVb5FGSQZb8GOeiBh7yMni8cqfojZJZs1rZSqvwRh/iAI0w3dWhPJ3Asp3d
         tFowNwy4BvoYaCk407teo0/1/7nPhHpT+OHcMQFIQylCCXzDqENeyLex8uQ08WCBOhbG
         sd3r81Ijc4sJBVfHmljSlhtSyMB9Hz3XwFkG2TvzNMhS15zjSgkdia1Ztd247u6lYCK+
         G4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779467915; x=1780072715;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lO05kaPnK84omNFj0tV7/7SdlIMyyOgvsJJzRhtWetc=;
        b=C2NpOi752dmA9VzRtZh3sWDTTKNWYOHgb5NXLveQDpJE9dWSWH5+lw/N1HIn7vVAV2
         FTKwMbA/oYvcNxX0PCwVlGCU3/RFB4wDDTWHZ7mwk4ytBhfXApop/r7bvIUPGfQRQkQl
         tgfNXW9B0konQxFqpa/0OOhVSj64ih7evQDna6eyR0nmrnrs5mwXfK7TFvUqfMvT/xgP
         cnB7u2EwVfaotLhJ3yNv31zzuhSyGTi8IGWje07npb23Snf/WqhWx3qAnsHCuPDSUMQ3
         3GFyBUahSUpR0AtB0Q9P8x5r3NDLyww5ZQ7xbtjrkzRxBdE0dLw6l1lYMzSPHVIkJKjA
         vGSg==
X-Gm-Message-State: AOJu0YwmKq+aT/MlRrBkeNXy5t1G1wI2LLEj4Nrhb7x+W5vJL60adzVc
	f3rBUldWuOfv3yK5+5pAU30LXGAHyxCb1kQcbaU4a65tpQfUOBRTUuu2Cns5oGcuN4Dty3WtF3t
	9bxw7sztT/y94Ov470KHQeuWkkKjNpfBR2+VZgXujG/YcQeAfJ6+oyWaP4+R5AX+LV2b6Y7OJW0
	uF/u2Ba0BkLptCktKRiVBXrWcPCNoLM0KN
X-Received: from plbkh4.prod.google.com ([2002:a17:903:644:b0:2b0:af2d:2502])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c2:b0:2b4:6d92:b002
 with SMTP id d9443c01a7336-2beb07db743mr47280415ad.37.1779467915211; Fri, 22
 May 2026 09:38:35 -0700 (PDT)
Date: Fri, 22 May 2026 16:38:34 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <ahCGijy722ITkND3@google.com>
Subject: [ANNOUNCE] Email reviews from Sashiko enabled for kvm@
From: Sean Christopherson <seanjc@google.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

FYI, we've opted-in kvm@vger.kernel.org for email reviews from Sashiko[*], so
don't be surprised if/when you start getting review feedback.  Given the broad
usage of kvm@, Sashiko is configured to email the patch author and Cc kvm@,
e.g. won't blast an email to the entire Cc of the original patch.

If Sashiko points out a real flaw, you'll likely get asked to address the issue,
but unless the maintainer(s) for a (sub)subsystem say otherwise, there are no
expectations that you respond to sashiko-bot (though it's totally fine and even
encouraged to do so).  In short, treat Sashiko like any other bot.

The signal:noise ratio for Sashiko has gotten pretty solid, so we don't expect
an onslaught of slop, but if there are problems with the volume and/or quality
of feedback, we'll adjust and tweak as needed (again, as we do for any other bot).

Thanks!

[*] https://github.com/sashiko-dev/sashiko/pull/209
