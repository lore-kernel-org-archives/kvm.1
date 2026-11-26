Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689021;
	b=Ei272VM98+i17e9wKE6LgX+tUoANatuH0QBPvopU2gRP1ARfSQh5RyeXqGQXqkXfMOoh
	 18eamILxhZllb+D8HFJzaSewRk4LpYfZbZQf+pq4RUbllVGOVsJB4f90pJeSvwJDaYRW1
	 Pq7l8tUFmUZ9kh6n9YXJCLn+BQ6K7BI6mJ9CHUz07BjPz3o2dpg2qXJxzJSI62q0Ymjv1
	 7cn2dbryg9Bui2tLCy5RmjSQ2RapGcAhWIgIW2ocpx0z8+QAHsYvBcF8/XFWwhOMr+djw
	 Wl1wx7nUkfGsgHL0l+cLBvL612RD4JVZw8vIXz/koTOKziBUKK2eHLORWVI5cQoxeyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689021;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=LPkkY012rBj1NU3mhpUYdI9eW0yjlTllGJp1koxH6mI=;
	b=JdWIkB8lwQCAayXvqh0Sunuydorcp6ei1Ht6H9+S5VPqZlZPPR7+7CmIdq8P2ALN69mr
	 nU731Ve9c/EtQPnvS854BNA0riD0O7Ld0uXyOgNm0QdA64krg1QwDp0YlHDY+SGJQMFiu
	 WGz8xuope/TjxkkX6Il4LliAJZjC5FMjxK0qAVUP0Fs8jYnsUd4mEunOxtg/5dWg9CQBr
	 DKkW4+35Uf1SVipa9iO9ZV4xQpksei4e1q95CpT1jsP1GrwbVuUP28EwNq7LYSYo4CNUg
	 Ag9J4yMaFlt3R2QORWymYcNXPFXKyQYv8N3pX803FxzJ3MC/r0NxsKY0UNa27vs18Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cmySS0di;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53B606A68B
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF53B606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cmySS0di
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795689018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPkkY012rBj1NU3mhpUYdI9eW0yjlTllGJp1koxH6mI=;
	b=cmySS0di0AT1W0uL9640+pZwyifvPq3qk/wMO7pgWGr9cmBEQw/uU4V0DyX1fDZu2L61Do
	BSip//RPXzaSJdfbMZRTiBDhxddU1gw5o6rSbP6FfQJVNsycFdrL9LjZt+4HM1RnnpNUdh
	duicSYvat1qA988lY00vFH2sGTsVmZ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-eQrEeSOANGaNDmkw7LnbBA-1; Thu,
 26 Nov 2026 10:30:14 +0000
X-MC-Unique: eQrEeSOANGaNDmkw7LnbBA-1
X-Mimecast-MFC-AGG-ID: eQrEeSOANGaNDmkw7LnbBA_1795689013
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9791F1956072;
	Thu, 26 Nov 2026 10:30:13 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 733571956087;
	Thu, 26 Nov 2026 10:30:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com,
	andrew.jones@linux.dev
Subject: [PATCH kvm-unit-tests 5/6] drop --enable/--disable-default-environ
Date: Thu, 26 Nov 2026 11:30:01 +0100
Message-ID: <20261126103002.2145135-6-pbonzini@redhat.com>
In-Reply-To: <20261126103002.2145135-1-pbonzini@redhat.com>
References: <20261126103002.2145135-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I would be very surprised if anyone is using this option, which was
probably meant to be used together with the errata system.  Keep
the variable as it is used internally to prevent generation of an
initrd, but drop it from ./configure.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure               | 11 -----------
 scripts/arch-run.bash   |  2 ++
 scripts/mkstandalone.sh |  1 -
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 7c9ebd49..9b325b54 100755
--- a/configure
+++ b/configure
@@ -53,7 +53,6 @@ host=$arch
 cross_prefix=
 endian=""
 pretty_print_stacks=yes
-environ_default=yes
 u32_long=
 wa_divide=
 target=
@@ -97,9 +96,6 @@ usage() {
 	    --endian=ENDIAN        endianness to compile for (little or big, ppc64 only)
 	    --[enable|disable]-pretty-print-stacks
 	                           enable or disable pretty stack printing (enabled by default)
-	    --[enable|disable]-default-environ
-	                           enable or disable the generation of a default environ when
-	                           no environ is provided by the user (enabled by default)
 	    --host-key-document=HOST_KEY_DOCUMENT
 	                           Specify the machine-specific host-key document for creating
 	                           a PVM image with 'genprotimg' (s390x only)
@@ -189,12 +185,6 @@ while [[ $optno -le $argc ]]; do
 	--disable-pretty-print-stacks)
 	    pretty_print_stacks=no
 	    ;;
-	--enable-default-environ)
-	    environ_default=yes
-	    ;;
-	--disable-default-environ)
-	    environ_default=no
-	    ;;
 	--host-key-document)
 	    host_key_document="$arg"
 	    ;;
@@ -504,7 +494,6 @@ TEST_SUBDIR=$testsubdir
 FIRMWARE=$firmware
 ENDIAN=$endian
 PRETTY_PRINT_STACKS=$pretty_print_stacks
-ENVIRON_DEFAULT=$environ_default
 U32_LONG_FMT=$u32_long
 WA_DIVIDE=$wa_divide
 GENPROTIMG=${GENPROTIMG-genprotimg}
diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 4e48585f..542da600 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -1,3 +1,5 @@
+ENVIRON_DEFAULT=yes
+
 run_test ()
 {
 	local stdout errors ret
diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
index 90507cc3..123be6ea 100755
--- a/scripts/mkstandalone.sh
+++ b/scripts/mkstandalone.sh
@@ -42,7 +42,6 @@ generate_test ()
 
 	echo "#!/usr/bin/env bash"
 	echo "export KUT_STANDALONE=yes"
-	echo "export ENVIRON_DEFAULT=$ENVIRON_DEFAULT"
 	echo "export HOST=\$(uname -m | sed -e 's/i.86/i386/;s/arm.*/arm/;s/ppc64.*/ppc64/')"
 	echo "export PRETTY_PRINT_STACKS=no"
 
-- 
2.56.1


