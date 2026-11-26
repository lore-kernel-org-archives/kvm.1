Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689018;
	b=yVQ+09DqMYSh2hBdFrMEbOTyBVf2l4ZTsWsoxcSAkiFzwac2shGYyqhT6XMkZ4w8vYZ4
	 qeOpT8fWFwZhy27E23QHwL4yqeG/jS471sr2FFHRshCtqbr0TWE3vBGTa3FM95Vk7CgiA
	 HPwjfT8GxvjDcBYBFEh6s9LNGgmx2qFV6q6WxSSzdEMtV13YyymgACoQE8RnIvudG3HFp
	 v+WdljTqVYwT0exP9wEECi5k8xXJDeyw7qgRmgvsfzKeNbp1akgBH1t0ewX0JCYQnwZ1B
	 s18g1AcLH9LdKd7HLzlFLTP8sPIvnUQUQE5Lxpwbi9GyNZHG9TNsNiU2iBJ5hLm4j4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689018;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=cRfIgfajfaB9PhJtPUnGo/Oa/C97O79dITOnRu1XYJ4=;
	b=p+YnMqnpF5U6TWxLWyaAVmAFT7QFcAY0pw8rDvw6TOCnIbZFMlC5x6vcPstFu08QFuVV
	 ynI/fkON6Nc9ExFoZYoOlBIGyvEAiqLPTBfCbE4TbBcxFiPpyPWwbmvWYRLk9OMEsRyEr
	 NyvaIPBr257+oLUeVLRvLSZWwjn4pt03sIYd6azVWChMFh/dENhloLjYF/GQLMAd4eRf/
	 GhhD1AmmwwknRG7gCsGCMCL0+RbA0jDEVmriQ2hgvV8piRMLJtw1WPmSQxFSIpgDAI7ja
	 Yy1l5LY0y0vZJ/jCcYfoWh7ocyzc4/qfskwFq59e77tI72jwq+fvpDMJnZBtfOEPWOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OGUGz7wR;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320E606A6AF
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8320E606A6AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OGUGz7wR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795689015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRfIgfajfaB9PhJtPUnGo/Oa/C97O79dITOnRu1XYJ4=;
	b=OGUGz7wRRzdgVEnu4s8mvZhCTNQQMWH65Zjqk91a6gbkH856V+T8yuu27AB+2kaeL/g6Ko
	A1PCsmqMAacuv3Eu6njut8L/qIMq1zR+cvnrrKAMXRujhsiuuImWA7rmF0fFfjo823Z5Ok
	0UAs6YYlfgGzpVHIkj2NXmN1x0jzolI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-OVqmBvuaP8ayEC7FMvhBOQ-1; Thu,
 26 Nov 2026 10:30:13 +0000
X-MC-Unique: OVqmBvuaP8ayEC7FMvhBOQ-1
X-Mimecast-MFC-AGG-ID: OVqmBvuaP8ayEC7FMvhBOQ_1795689012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1203418002D7;
	Thu, 26 Nov 2026 10:30:12 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1A3C1956087;
	Thu, 26 Nov 2026 10:30:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com,
	andrew.jones@linux.dev
Subject: [PATCH kvm-unit-tests 4/6] do not pass information about kernel, QEMU or target via environment
Date: Thu, 26 Nov 2026 11:30:00 +0100
Message-ID: <20261126103002.2145135-5-pbonzini@redhat.com>
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

No test is using these environment variables, and for good reasons since
filtering of bad test results is not something that individual tests
should care about.  Rip out the code and documentation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 README.md             | 12 +----------
 scripts/arch-run.bash | 50 +------------------------------------------
 2 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/README.md b/README.md
index 7e377680..ae763b5d 100644
--- a/README.md
+++ b/README.md
@@ -122,17 +122,7 @@ Additionally a file of the form
 
 may be passed with '-initrd file' to become the unit test's environ,
 which can then be accessed in the usual ways, e.g. VAL = getenv("KEY").
-Any key=val strings can be passed, but some have reserved meanings in
-the framework.  The list of reserved environment variables is below
-
-    QEMU_ACCEL                   either kvm, hvf or tcg
-    QEMU_VERSION_STRING          string of the form `qemu -h | head -1`
-    KERNEL_VERSION_STRING        string of the form `uname -r`
-
-Additionally these self-explanatory variables are reserved
-
-    QEMU_MAJOR, QEMU_MINOR, QEMU_MICRO, KERNEL_VERSION, KERNEL_PATCHLEVEL,
-    KERNEL_SUBLEVEL, KERNEL_EXTRAVERSION
+Any key=val strings can be passed.
 
 # Guarding unsafe tests
 
diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index f585de7b..4e48585f 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -395,63 +395,15 @@ initrd_create ()
 		[ -f "$KVM_UNIT_TESTS_ENV" ] && export KVM_UNIT_TESTS_ENV_OLD="$KVM_UNIT_TESTS_ENV"
 		export KVM_UNIT_TESTS_ENV
 		KVM_UNIT_TESTS_ENV=$(mktemp)
-		env_params
 		env_file
 	fi
 
 	unset INITRD
-	[ -f "$KVM_UNIT_TESTS_ENV" ] && INITRD="$(vmm_optname_initrd) $KVM_UNIT_TESTS_ENV"
+	[ -s "$KVM_UNIT_TESTS_ENV" ] && INITRD="$(vmm_optname_initrd) $KVM_UNIT_TESTS_ENV"
 
 	return 0
 }
 
-env_add_params ()
-{
-	local p
-
-	for p in "$@"; do
-		if eval test -v $p; then
-			eval export "$p"
-		else
-			eval export "$p="
-		fi
-		grep "^$p=" <(env) >>$KVM_UNIT_TESTS_ENV
-	done
-}
-
-env_params ()
-{
-	local qemu have_qemu
-	local _ rest
-
-	env_add_params TARGET
-
-	# kvmtool's versioning has been broken since it was split from the
-	# kernel source.
-	if [ "$(vmm_get_target)" = "qemu" ]; then
-		qemu=$(search_qemu_binary) && have_qemu=1
-		if [ "$have_qemu" ]; then
-			if [ -n "$ACCEL" ] || [ -n "$QEMU_ACCEL" ]; then
-				[ -n "$ACCEL" ] && QEMU_ACCEL=$ACCEL
-			fi
-			QEMU_VERSION_STRING="$($qemu -h | head -1)"
-			# Shellcheck does not see QEMU_MAJOR|MINOR|MICRO are used
-			# shellcheck disable=SC2034
-			IFS='[ .]' read -r _ _ _ QEMU_MAJOR QEMU_MINOR QEMU_MICRO rest <<<"$QEMU_VERSION_STRING"
-		fi
-		env_add_params QEMU_ACCEL QEMU_VERSION_STRING QEMU_MAJOR QEMU_MINOR QEMU_MICRO
-	fi
-
-	KERNEL_VERSION_STRING=$(uname -r)
-	IFS=. read -r KERNEL_VERSION KERNEL_PATCHLEVEL rest <<<"$KERNEL_VERSION_STRING"
-	IFS=- read -r KERNEL_SUBLEVEL KERNEL_EXTRAVERSION <<<"$rest"
-	KERNEL_SUBLEVEL=${KERNEL_SUBLEVEL%%[!0-9]*}
-	KERNEL_EXTRAVERSION=${KERNEL_EXTRAVERSION%%[!0-9]*}
-	! [[ $KERNEL_SUBLEVEL =~ ^[0-9]+$ ]] && unset $KERNEL_SUBLEVEL
-	! [[ $KERNEL_EXTRAVERSION =~ ^[0-9]+$ ]] && unset $KERNEL_EXTRAVERSION
-	env_add_params KERNEL_VERSION_STRING KERNEL_VERSION KERNEL_PATCHLEVEL KERNEL_SUBLEVEL KERNEL_EXTRAVERSION
-}
-
 env_file ()
 {
 	local line var
-- 
2.56.1


