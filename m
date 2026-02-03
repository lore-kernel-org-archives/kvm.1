Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98133D50E
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120235; cv=none; b=DkzZVkVGVJQ+f8l+4ZDMomMuoLSTxxL2/Ku8/PEhrwuLfwkE0tv+U793L3oqlwB6Nbdfklwyo2gaRhzI21FU1mcgE7CXO3R1EEdzIJhaQNxsJZa4EGl4xcc0Th4fKMc6cCNxd9qiZ9n+Uwws1sFdsLMYIgcm+5iG75UuOhLUDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120235; c=relaxed/simple;
	bh=RehSTsHOnzOJtWzobHWSgcFPxHOiJy1L3ptBiOtdVT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB9BQws+zBoUTmL/OjnDl46kOnCmEjhXrsqp9TO2bgDjYPpmMdgdlzAXn56sZtlVx8Oor6rNKGaTJ2VM3jtOJPpoElsidnM5e0QXPYp2LU+U1QQeDUM32IUwiL10uWBrnmgZ1JzbzumOwSw8xQMUxHvqTGO4otrBDmkUMD6Ubjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chkpbzVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chkpbzVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy03svltU4Y5GVcVkCL5E2/K3QxUGGXfGHcqgu8QIGQ=;
	b=chkpbzVe2LTUIUTcHwk/Sx9PWc0FkNYZhCmHyJKG24V3vChsvjCYd2+jPqpeKGTnjtV6hn
	n7AOcATELA2FyfZdEe19hnE3nPCDKa0050MiC4bwL0a+roUEj72I+06x0RIPxtY1e5Ml/Q
	kT3Fo7JFY3be5QnuANSA+l12+0ryzVQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-EUMjdSCPO76xXldnEZT6-w-1; Tue,
 03 Feb 2026 07:03:50 -0500
X-MC-Unique: EUMjdSCPO76xXldnEZT6-w-1
X-Mimecast-MFC-AGG-ID: EUMjdSCPO76xXldnEZT6-w_1770120229
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F0881956089;
	Tue,  3 Feb 2026 12:03:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CA8A30001A7;
	Tue,  3 Feb 2026 12:03:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 88D281800606; Tue, 03 Feb 2026 13:03:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Ani Sinha <anisinha@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Eduardo Habkost <eduardo@habkost.net>,
	Zhao Liu <zhao1.liu@intel.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	kvm@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 02/17] hw/uefi: skip time check for append-write updates.
Date: Tue,  3 Feb 2026 13:03:27 +0100
Message-ID: <20260203120343.656961-3-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Only execute the time time check if the EFI_VARIABLE_APPEND_WRITE bit is
clear.  For append-write updates the timestamp verification is not
needed.

See uefi spec, section "8.2.6 Using the EFI_VARIABLE_AUTHENTICATION_2
descriptor"

Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20251104102714.733078-1-kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 8533533ea5c8..52845e9723d3 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -475,7 +475,8 @@ static size_t uefi_vars_mm_set_variable(uefi_vars_state *uv, mm_header *mhdr,
                 goto rollback;
             }
             if (old_var && new_var) {
-                if (uefi_time_compare(&old_var->time, &new_var->time) > 0) {
+                if ((va->attributes & EFI_VARIABLE_APPEND_WRITE) == 0 &&
+                    uefi_time_compare(&old_var->time, &new_var->time) > 0) {
                     trace_uefi_vars_security_violation("time check failed");
                     mvar->status = EFI_SECURITY_VIOLATION;
                     goto rollback;
-- 
2.52.0

