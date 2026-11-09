Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263507;
	b=v+LUAECD6yGeX5JUSMpPyR0yKuh++G4gYWCF11Je6E8e7UyqqSMkIwsWirN8N5CzuUoy
	 ho5fXwxn6AeqBDj1GbTVgbVRMBx4VdweRzEf8GBKKageypZEtOUIOYIYF4QCabxqZTW4e
	 gSJSoc7Zb5OvNdCNUjHEZgov6lAnidiTvc/cu3SrTyK3p/K/UpXYwUjFvTrFX3tEgfKGA
	 y1QHnhCck90vigNrWUXi4isnciatx1TQDCKFAXthv/E3+ZpUgVDJiWY+zalhvvZm/A+c4
	 KHCEH+lEIIyN3UKkP2iX7dMx76yAXI++PhTpNnUKXSr+xV5urK4Hk6mDUKQKF27uR7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/mw9MRLyLESc8KIvtqveP6obTMbEMi6oIn8oBDFbEyA=;
	b=TPFxLAOVZ1uKywUp+jsa0fvFovDKDVIpj2wlE1n5BcV8mMqTl+xTiN6nv/rb9odOyKjf
	 bKlNGZyUpzMb8vbGaNVKsWFScrWjW9EBrQt5lUnlWbUVc2VQHPW9tLicFprZhBY5REG88
	 3RbQiAFf4BBt/ryHgk8DURiKVTnTrsOvW1r0Ne3mrPHU2Oz3pFGF7rxlkQNgFz/FKj+Zp
	 Obj0GZgeF5IWq+wF4CmNJpt6jikzDw62T6+09ubHCfxzUwwqsgRdM/R/w1lUavn8l2ikI
	 ZRfu3/lLDFq2iINbX2nN8kN5AVH7FoqQraH6BvjZO+siRHPHKR5GvNT+P5RYuuKkfHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qILLx21p;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39B60A260B
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C39B60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qILLx21p
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so974727b3a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263506; x=1794868306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/mw9MRLyLESc8KIvtqveP6obTMbEMi6oIn8oBDFbEyA=;
        b=qILLx21pYoPRkO0lQ9pjsuR8zWhU3xENUIxv/hTSLcoz8timDNN0vL+n6Ixiq4M0oi
         k3QJfKNgnYHFkO0iGmjIRf9RWPTdkVTbh5N4A2dAd/JUXr96vQr9ri5iYVeDH3rlrclL
         icO/Tnbjp2sb+WBo4SUlK6XNgzSkkqvVJsuN08czQ7Hu/4OBY9QKTalRGlFB81fXntKl
         fUlClj0eyKdjpNtNPktu1vSy6uaOg8NGEUFXxjkB5/1oiEyvTGZsiHTzG2BsF67wE/qL
         mJomxXJq8lPapM7ikVUyEVdjMQ9uWjEYXnIyt4iO1DlzIi8PPBUr1moG6KY+ZMSLT1fY
         hGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263506; x=1794868306;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mw9MRLyLESc8KIvtqveP6obTMbEMi6oIn8oBDFbEyA=;
        b=sV4P2810G863OWjbuw+RReNextfrnp0qOLLSaIw+bRapZWg78hz2nBSrpfTSpsjfVU
         jpNw4Y3UeJkJ9sng2c3T52B78HGVdsI/Kg4jl2kTb+NTIq4TLUP37puJLQUGViS3KRA6
         FWMJ+AgAGndj/iR78ITSRoHir5lU5QzZg8Xk8iFAzvPegxSF5ImKW/Ni3nd97ggBJns4
         g3Jn/pn5DOD/5rx5odSKfa5bjNgFH1pIxUq9aOBgA3U07Eb/QEYngejeNIoCcTCPuEH5
         b2snYNPELcfgcliDW3LTR+VLvuUvmRdIh8+TQ3VEkap+H3s2V+mpzMzjIydjWaIBuxbJ
         gvyw==
X-Forwarded-Encrypted: i=1; AL+hErEyZgoKtqrYExCExjE6tKMFY1zRJ7M3T2d4+WKQcMy/cCwjIPrbSrV4bVjgWSR2eqlhKnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OaohWFAMVrlpGw0Hus0nwp1GD+kjOpN/lITDwubbbF9MV0rZ9
	XkviuY0RR3mMjOFy2CzmuY3GTgseivqs41PuC/8qb6sleZ9ac4IWT4mPqUJTphRKNrk=
X-Gm-Gg: AYBFou3DspMNVvglP9LvnolRAIEaUOfTu3zCWBAJc7zl73V63fWKIXXicutWRVlXWx5
	AqKL9thj8R8yJfoU9El3/KoLhENHfeYz/0PsFO0IG4kz50INjesUpwgRjid4ZL7KylhKH0/ZT1M
	Ragy+qWVGr3GbiktbwojOA8K6ZSIZKXQIBbpAj0akJIE9N4a7DJkcalHDlvVABdfXjXKDFlRpg6
	Nh8kAZjylLMZ8C44Rc3pYfKDRVG7Qefv65QWfBvnSbhLbA/T5oJF6ykehUdlOzbF3tG2NAKmOJl
	rNykV4+s8joxjgDwnAV5xOPtwteAlPT2oYtERARp1NROspqKTp9ZVh0P2FK3W9UiKVQl9FKuf5q
	Swj+PSVGqjJtWjxKNJTsvoWxagbYeKVuvnwaHKdgLv1qQsD1R73E3g32jlZBjXlziD64CE/wftQ
	wv47O1IohJjorwBD49Ff8joplnxdVzQFusjefgsBpsdL8TzbfnrRpAYiRPNu/T1A+l7kPy7EXLY
	hAkQurJ38Suud/E8xw5XChMsILA1cgJrN6cjLBvbMpwntmWHCQ2BsM5kxHP/iyCsV8rHNOgKl+I
	ut4l06TyxviqbcxM0ukKWnA0zhPSwEQi7+hocbRVr+d65lVQekGp5Q==
X-Received: by 2002:a05:6a00:1496:b0:886:cde6:694b with SMTP id d2e1a72fcca58-8ba89f19b98mr876605b3a.38.1794263506327;
        Mon, 09 Nov 2026 14:31:46 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:45 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 18/23] hw/arm/virt: Move virt_flash_create() to machvirt_init()
Date: Mon,  9 Nov 2026 16:31:05 -0600
Message-ID: <20261109223110.1619504-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d53ed4d51ca..f1ca233a1566 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2922,6 +2922,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4444,8 +4446,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.53.0

