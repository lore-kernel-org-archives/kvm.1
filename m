Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600372;
	b=krbPdxGRid8nsmaM/+daAG50hQWpc/4d+tr2JqXKkzBk/+DINKKCTnOXTP3cYlNn3V45
	 A7QX7NZEejExaxuqQIBCJgYNvFsaAYnoQQUjbWY57OsJ3VG/In3pCt2yLER9Ns3S/4v4g
	 o9sr/v5VVjRKb/Nce+4vP9A1XpRcF61DNAu2KxrEeEAe1NmqNXQUgkSwBZmChTySskMPA
	 8JEjY63aKYVpyOiZEZyxLKwbW/CVkHJdBiaNvKv69E1Oza2zc/oDPHQh3B/7TET0CAjKG
	 0Nl59AoKEGazf9CLZqyg7vrUScdby7ePd7/8pwnSwTw4sGZDW6N9PCyEvMpRbXmGh5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600372;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=OtTEJg5RIHFFJ9ZZ5a0yaGlFu79+ZaA7uoWE9DGvTDw=;
	b=LM3cbSpMNkMbSOIHyJISokuZFa1whHumGosTKEpbTAgW5Qsklnl5WBoSdws0qjE29/yc
	 zlYHmCpj0p74A2ncQiNqqySQKIVWuCOYXK5W69rfQECpZwsUv9NEW5pHKCe8uxvm6ywHu
	 pIy7KPYUWcPeGSvdLVLKXc7QfCm/KGuvXrep+HQmkI6IoscOyYkBRKnLSnOvTjM7TTTyw
	 Bs9aMSvKkjNBgLYsMHn0yPGu2HztJMsinEPBiLyQkleQE+NxCQvF/i7Fa9o+2KCvsOj9h
	 WSFa40xGEmAkO00y1iw/9RZ2lrK83KfH9mTP8vJqqKonLgNqjX+orB4p0uGyBs82wOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZ0A15WP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0A606A331
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDF0A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NZ0A15WP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtTEJg5RIHFFJ9ZZ5a0yaGlFu79+ZaA7uoWE9DGvTDw=;
	b=NZ0A15WP13cKzmKW3LCbLGyNDogbg7zXVZWpKaZvh0igL88OB27umyzvKckXfiCuk1p7ss
	fZR0mGCMWmHhkZ9xzp/GvbKKqD2SjV/4WMKsJPK78bjy1dJhJWKtcibCEi5heCCG0KlBTR
	JBiaPN+7OMFUsP1zsuwkMOdnWUDoSPk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-EyfYKAXeOG636wyFjUSQHQ-1; Wed,
 21 Oct 2026 12:32:46 -0400
X-MC-Unique: EyfYKAXeOG636wyFjUSQHQ-1
X-Mimecast-MFC-AGG-ID: EyfYKAXeOG636wyFjUSQHQ_1792600365
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FFC71955F1B;
	Wed, 21 Oct 2026 16:32:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A4EC5BC;
	Wed, 21 Oct 2026 16:32:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 2F82F1827597; Wed, 21 Oct 2026 18:32:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 09/10] docs/system/igvm: document MADT, COMMAND_LINE and DEVICE_TREE directives
Date: Wed, 21 Oct 2026 18:32:37 +0200
Message-ID: <20261021163239.1131460-10-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Luigi Leonardi <leonardi@redhat.com>

The MADT and DEVICE_TREE directives were added without updating the
list of supported directives. Document them, together with the
COMMAND_LINE directive added in the previous patch.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20261019-igvm_command_line-v3-2-29aeacbd6cd7@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/system/igvm.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
index 9db8ae43d21d..da1e965f545f 100644
--- a/docs/system/igvm.rst
+++ b/docs/system/igvm.rst
@@ -72,6 +72,14 @@ SEV-ES, SEV-SNP and non-confidential platforms.
    * - IGVM_VHT_ENVIRONMENT_INFO_PARAMETER
      - The ``memory_is_shared`` parameter is set to 1 in the guest parameter
        page.
+   * - IGVM_VHT_MADT
+     - The parameter area is populated with the ACPI MADT generated by QEMU.
+   * - IGVM_VHT_COMMAND_LINE
+     - The parameter area is populated with the ``cmdline`` property of the
+       ``igvm-cfg`` object, or an empty string if it is not set.
+   * - IGVM_VHT_DEVICE_TREE
+     - The parameter area is populated with the device tree generated by QEMU.
+       Only available when QEMU is built with FDT support.
 
 .. list-table:: Additional SEV, SEV-ES & SEV_SNP Supported Directives
    :widths: 25 75
-- 
2.56.0

