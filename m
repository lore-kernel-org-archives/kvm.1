Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47D472089
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257375; cv=none; b=s+x1ve+aOYFijKf1E9W7MhTlGiMaP1PC6KrEcl1yrSlPXMlxTX/qx0lshXrfiGweRlO22DrJE/8tVdkqJ/mS/Z46r4xjb9chHFoZvNbNGCbj5M99Px7r6YQC5iJnr8kdTj/eoSFnHeASa1NIcycD30NDC9FBYO9Ck85/Emy6s2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257375; c=relaxed/simple;
	bh=FkFLGNVGLOmE7HAGAxodhauiGvqpVa54gTmyFBM1Xwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QM8QIz5yaYh/LLuMIplZI00dHpGBCwqL5VRsvu5Ml1NjmpTGRhuX9bF/Q/IEs6zQsarjWlOBOFerpDQVWToXJG47AlleVm77PfHD737fvR4qllM0Djb/XQbCS0sX+1swalQT4qVJdxUbA3bHjuE3YSa+fUgSEGwkxqkr5vXJ+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmQhLAoQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJm/GVe0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmQhLAoQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJm/GVe0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788257372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Dzi1bBTzXXjpEm5tVaw17VipUCXdh9YJHGDHV+JNAg=;
	b=OmQhLAoQn9m8fT2fiG4y4Y4PIrWBESlpoq3F2OKP0kjAtCJmRt40/1P+7DVowL0hI+07UY
	Q0w50AXG0XPFFNw/esgHR3r/opGLgXOPGCH6s14Ym+OixDQzYj21V1K7AGXEzewfkK6wJT
	D898mEWT2ZTo8cg2+m/nchiafjS1m9w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-bQJMNbKsOlqBen6V9_I6Lw-1; Tue, 01 Sept 2026 06:09:30 -0400
X-MC-Unique: bQJMNbKsOlqBen6V9_I6Lw-1
X-Mimecast-MFC-AGG-ID: bQJMNbKsOlqBen6V9_I6Lw_1788257370
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f726186c4so2573877f8f.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788257369; x=1788862169; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Dzi1bBTzXXjpEm5tVaw17VipUCXdh9YJHGDHV+JNAg=;
        b=ZJm/GVe0+J9+UBVg8DIb7ZVsV0KQbbiidbcwsrcPRQcqMJJNkXs4VrqzfHorUth9Fz
         494q5rOtf6Cbtp/2LswzkS50BjZd92bBm5AF8hbsxRDhJg/Z4OIuJab9k+9xqjJG5T9u
         ytbfszilbGT9c4uUqVyE0mUSS4NFM0ZHEM89d1UBXsi1yi7JYsWBqiUQuZGet/3uIi1U
         xI+bq6t9pLlMfn2rzF1PAafUyZMXSP5XYNSZu+za48L7j/eTdm7in5QoNIKLSoLM7ULl
         cdAvnVXmLVxfixUqZQQjOtUk3iNVF7KWdq2LLeq90zAhzl+njBHaCMvIJgsazXI95GsI
         sNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257369; x=1788862169;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Dzi1bBTzXXjpEm5tVaw17VipUCXdh9YJHGDHV+JNAg=;
        b=nGXJkae3RAXIwfxU/SujHF6nY5jM44wJ0meevnsGszAnGQzSeNqugr2Oqhmw6QLBOC
         LcsvNM6/P86wngeDkvBaXd5gqM8SApyy9hLJ/kLsQtdlPamtf+YoI9DCh2O+WBSubmu0
         Xezkqs/eGjBQ0Rq8N0m3zDK3dpkhPSc0y07dAWGCc5DHdyRIDLj7pfEJFbMp9sggqGEB
         UhGbEQWTq82XwOUqJzg4/by6jWm+rcFJlGqCpRVmeFqKtNZMX4/y6CSffrUYsw1I3j52
         HdRh9TEoI/KYz3NBcxV3p9RBz2ZcjL3cb6GkfcwQcxR16qXAlyg2XY4N1F0djcWww5bf
         sF1w==
X-Forwarded-Encrypted: i=1; AKwUvBxHVZuwCKf1DgQDF8ZYiKDh1FO/1F7tSzaH/ZLcJvN4Q3peZ7B3if1KbfJL8SwduzPgrvs=@vger.kernel.org
X-Gm-Message-State: AFuF++llEcLWGiPe69dfsaqs9O9kY32Y3ZBrrnM2EWOAbtCx1ITBUemM
	fhpOQLm1s5tGM0UTKbFf+avEsiBC1z3uuePyFSQd9Z19VZUebin/IACg3+lGOvH8Ur0dN+0pz6k
	x0kI508moKTM7ur/AmHZApeEwArE644OqjgC+RUMiMXkD7jLJUAgxZLAvpbBKl4Ungtlj4MB/Zq
	BTGbeZ4IIo1Vdm1NUq/bTjidncsZCHOPtdmfSvh2ZZ
X-Gm-Gg: AYBFou1EDnHfhjQ/1TELkUnJMvUXo+sIXhx9sO+hCwtLlvcLGCQ4DqX5ZbxL+5UJ7t4
	sUuwlhCL+vdzgJhsIQxWZYbp6z3Oc9P5mzErBova0yD+vhqnU/jCOodSiST6uZa2WVi5g2Lp+2u
	15qMMWZa41TFCPkHTI4CMneIJs37hYXCFN2E4PDRIXuuoiXEhVsvhghIzabKvpUuvtueqQwyzfY
	eXso+Z0hc/avBOEkIFMWEUN/G2OONALKxMUcCy0MTuxAU8lnKj+748qSCchzaUv0cQnKTtABCdS
	G0FJnj1phjpnvfjqLniMFEsOZFO8QRZmyHDErh0bLOEr5V9BAzEcfJmfIWiq7VddjWcgFhEhkeq
	gY8XVP7cDWh9E6xPMx1yK1p8ewGRx4ahdsXcdi6iu8gP/UBZuX5hDyIWZJiWW6XT9nrw/
X-Received: by 2002:a5d:5e01:0:b0:480:c5:d635 with SMTP id ffacd0b85a97d-482f782a4a2mr47922528f8f.0.1788257369603;
        Tue, 01 Sep 2026 03:09:29 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:480:c5:d635 with SMTP id ffacd0b85a97d-482f782a4a2mr47922420f8f.0.1788257369163;
        Tue, 01 Sep 2026 03:09:29 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:09:28 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 0/4] igvm/sev: apply the IGVM guest policy before launch
Date: Tue, 01 Sep 2026 12:09:17 +0200
Message-Id: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAAryL7naBGUV0lQky3WughClJId0/6H
 JiZDBEDYYSBZQiYKNJ1FpAVA7uZc0VOrjAooVrR1ZIvdGta06H9tZN9uJh75bBRzrUGSuUDFuU
 /jtP7fiupNzFhAAAA
X-Change-ID: 20260831-fix_igvm_policy-0b92de52dd6a
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

The guest policy from an IGVM file never actually made it to the platform
before launch. The callback that was supposed to forward it ran after
LAUNCH_START, so it did nothing and the guest was launched with the
default policy instead of the one requested by the file.

The policy is part of the attestation report, so this quietly breaks
attestation: the resulting measurement does not match what the IGVM file
was built for.

Patches 1 to 3 are cleanups needed to get there: dropping an overloaded
callback, moving the SNP ID block handling and giving the policy
properties proper accessors. Patch 4 is the actual fix.

One thing worth calling out: if a policy is also passed on the command
line and it differs from the IGVM one, we now return an error instead of
silently picking one over the other.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (4):
      sev: rename set_guest_policy to set_id_block and remove dead policy code
      igvm: move set_id_block call into the SNP ID block directive handler
      i386/sev: convert the guest policy properties to custom accessors
      igvm/sev: forward the IGVM guest policy to the platform before launch

 backends/confidential-guest-support.c       |  17 ++-
 backends/igvm.c                             |  85 +++++++------
 include/system/confidential-guest-support.h |  28 +++--
 target/i386/sev.c                           | 181 ++++++++++++++++------------
 4 files changed, 174 insertions(+), 137 deletions(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260831-fix_igvm_policy-0b92de52dd6a

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

