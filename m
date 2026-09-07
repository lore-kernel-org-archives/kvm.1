Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F263769E8
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796630; cv=none; b=l+q1CjnKdMZsnZODzLz4/Ulm515pXMa5QrHDfsm5yUQkMf41ve70xSGKNQhY+OIhqGAFRV5ijiLM3O+f+tw7eEQWmoV8CaIavhVynqxiNPuRf8wrhwgMyfDmx+Ok3KfnxllObTX5cj1oPe20ruG2G5UOwzd0NJY12ddMM1/G7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796630; c=relaxed/simple;
	bh=nuo1dUynOxbsL17n+ttXRhy4oTQhMXIAUPb9ezvNFAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nPlJBMweTRdXwf1UKqyciwGaDkHyRq7eIK6+oas8RQykTbjjmi0VYuhD5JODUXDaziKUoNDBuetFxCtD6GtZ8Rg+dnC3hcwTXKO+iHXjRrR7z0azaWjFuOZRwbTFEJqdXJO5xDgcOMli2Kjp3hnEQXCzO4uaKW4wnevD+hLRpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPTuj6Z+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVHdQ10E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPTuj6Z+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVHdQ10E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788796627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=44LJSGbizEpHP9Q30K0BBKNpjLqbODu1E9+RgeLgeks=;
	b=aPTuj6Z+iRBNi9jt1KetQ4hQswOF2ns2W2y/xvYnOTRSfy7vLE8Pk8lVY0xKZsAYmazIPr
	Pi2jTbmJWetTw8/cO0hrf7ObR97N3DVL96cEPnQrT8cuyLtATaGvEoK2amPyMsDkollcvn
	b/1eceGgUOhWAaGths/s4Iz8v3OuVwY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550--FrRJvESN9yvD8ufIYj84g-1; Mon, 07 Sep 2026 11:57:05 -0400
X-MC-Unique: -FrRJvESN9yvD8ufIYj84g-1
X-Mimecast-MFC-AGG-ID: -FrRJvESN9yvD8ufIYj84g_1788796624
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49545071724so29254325e9.0
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788796624; x=1789401424; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=44LJSGbizEpHP9Q30K0BBKNpjLqbODu1E9+RgeLgeks=;
        b=VVHdQ10EA2Ld4yZybAgUhJQ2EIX+JJ7f5IykyF5LtxWcxribftbKON5zqOP75joeOU
         hQAun+7L0LWQSAty3NUhWRMoDcl5LKyMiiV4QpAC0qqjvZKvV7zCdE003dHGdbgKuftI
         Wn1oDYyV7lZFN//XhCyx5ycKQSOULTlmk3AlkwBvvUc2AlXL9Ro9HqOwY8YCorSrGP25
         AnABKMmC82fYpMmc+893gLPD2cSLI1ugqKEGXp01umSk9jJE6ybqKg59Nb/tqOmoHi6Z
         dbCSGrXfcrWY0VjxIGdngUG5c0BnO4NvSclw1Ih8e9dqocfX7WbJEw7jmweCt0SkJTe3
         ShpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796624; x=1789401424;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=44LJSGbizEpHP9Q30K0BBKNpjLqbODu1E9+RgeLgeks=;
        b=dIvEERZWQshynRbT018lH5WBGcusPjrvzVq7QkiqC/kaV+d1XS6D0+q2vgWKyBVoPg
         aCd60Nc3MEKeMTKrhfP+OfdNTRNaISPh9Xx+eCz1t9Abw9mLqjuqXAUVOS2ROTvJOTWH
         aUBAQ5z6iY66URsXU6RsDpoB+Vfgn1EHVUHvDWbUyQh+Uf//sAbUWCXLeJGkTs722PDu
         I8tC+O6W7Unt5yWnp63b3RjkYbmuQfxLa2JC3dWrTd5HGf3pmyjw9hwArlzkqBjeOvgc
         dmxx+eHohFHTTS6j0d6cPkr2xaQlA58rxz/0BmVNvmMe9PO+ne2TrbmXnyAT8YhUMbLU
         Ln0g==
X-Forwarded-Encrypted: i=1; AKwUvBy80BPv5Nlra79oejwc6lDQHvCRVFN2DTxg2ACMkFyx4Aikq1v64tzwPqnunUNNhiuV6XM=@vger.kernel.org
X-Gm-Message-State: AFuF++m0Z7eEku5kEnnX+Yk5azbiE4ZByuLWGzxVcfNGrD/13/ROVKWP
	1XfJe8mceeqjd11G/mqpSrPABJ9WCHYQsySKadiqS/5GlWzL5OrOlb/6Cvs/6+SjsEXq+VQrF9N
	d6Xj+W9RphbhmvS2noeKNkp99jeRwMGxQo8tOiJqfbkuYpcc3LbS9sg==
X-Gm-Gg: AYBFou0tvQcGDHxNWDXQuPIvSPQwJ24s4WdIYFpleevAowoDkcvf4wQRC2eIJ0nc1fP
	KDS9bATWwcMF0Gg83tqNUipmQjxz9RMhuVuMNUJ5iYLGThaiu2Z8u6Dh4ePdWRBhjF1Me3KSpf9
	g/tBIDX1u09x5QDSJHJ8PfkqNiQTlIm91CtkMPkJ+VmhGvAC6HjN8KkpF7aGY+giYm7MGXnPYPh
	MsOsFTKTAKdPc6tuipS4ZHiOZbDHaewl3mWPVWvKuntcHXNV4hZ0QjFwKkOwYTnhQr5UXQUYeze
	heLfy9ek39FMjMJJUtbvIdN708P06m2ojC3q47uljlgakjq+SaTUeGQl9pTSLtoZx5YUnmGGAAG
	euF9QJz1JWfWl5GrZZK11LhdP6KT4MByknQc/j4aH/6zi1S5kk+ecmPu1ivKqxbIP6/XX
X-Received: by 2002:a05:600c:8b88:b0:49c:db20:da13 with SMTP id 5b1f17b1804b1-49cf822a707mr251495325e9.5.1788796624434;
        Mon, 07 Sep 2026 08:57:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b88:b0:49c:db20:da13 with SMTP id 5b1f17b1804b1-49cf822a707mr251494955e9.5.1788796623947;
        Mon, 07 Sep 2026 08:57:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:57:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 0/5] igvm/sev: apply the IGVM guest policy before launch
Date: Mon, 07 Sep 2026 17:56:56 +0200
Message-Id: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQqDMBREryJ/3ZQYMZiueo8ikiZf86EaSSRUJ
 HdvapddvmHmzQERA2GEW3VAwESR/FJAXCowTi8TMrKFQXAhedfUbKT3QFOah9W/yOyMP5Ww2Ap
 rpYayWgOWyml89IUdxc2H/TxI9Tf9uRT/d6WacYaq0dKMnWm1uQe0Tm9X42foc84fJ7pYQ68AA
 AA=
X-Change-ID: 20260831-fix_igvm_policy-0b92de52dd6a
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

The guest policy from an IGVM file never actually made it to the platform
before launch. The callback that was supposed to forward it ran after
LAUNCH_START, so it did nothing and the guest was launched with the
default policy instead of the one requested by the file.

The policy is part of the attestation report, so this quietly breaks
attestation: the resulting measurement does not match what the IGVM file
was built for.

Patches 1 to 4 are cleanups needed to get there: dropping an overloaded
callback, moving the SNP ID block handling, giving the policy properties
proper accessors, and adding a way to read back the platform's current
guest policy. Patch 5 is the actual fix.

One thing worth calling out: if a policy is also passed on the command
line and it differs from the IGVM one, the command-line value takes
precedence and we print a warning instead of silently picking one over
the other.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Rework the callback split. Now we don't have an unimplemented callback [Stefano, Gerd]
- Reject a command-line/IGVM policy that doesn't fit in the 32-bit
  SEV/SEV-ES policy field instead of truncating it [Stefano]
- On a mismatch between the command-line and IGVM policy, print a warning and
  keep the command-line value instead of returning an error. [Daniel,
  Gerd, Stefano]
- Picked up RoB
- Rebased to latest upstream
- Link to v1: https://lore.kernel.org/qemu-devel/20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com

---
Luigi Leonardi (5):
      sev: split set_guest_policy into set_guest_policy and set_id_block
      igvm: move set_id_block call into the SNP ID block directive handler
      i386/sev: convert the guest policy properties to custom accessors
      i386/sev: add a get_guest_policy callback
      igvm/sev: forward the IGVM guest policy to the platform before launch

 backends/confidential-guest-support.c       |  24 +++-
 backends/igvm.c                             |  91 ++++++------
 include/system/confidential-guest-support.h |  36 +++--
 include/system/igvm-internal.h              |   3 -
 target/i386/sev.c                           | 215 ++++++++++++++++++----------
 5 files changed, 230 insertions(+), 139 deletions(-)
---
base-commit: cacd3462963a0a4f5bab4263ce79c2aa4b32692d
change-id: 20260831-fix_igvm_policy-0b92de52dd6a

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

