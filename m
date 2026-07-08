Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7113002B3
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 04:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485461; cv=none; b=ViCE09X6UJydBum0AWaTobqikmhT1KmL7is4YzczxgvJSt/U2Nrwi0fJ7MxCAsRzArBMtjmbEfkZL0T4uybV/wPTIZGGt4utneWQcAidukz4m/Lvy5+txuB2dw+odflndbrCre8JYbYUkknnsxPj5YkTKZp+nLusDP2+sCCeEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485461; c=relaxed/simple;
	bh=wxGj7CR54xDSa5dTZgxIMhuPluvM0megdkTIIwr+KeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+vbAIq6LDt3vUxcHGFsGLW/aIEFXbbG7bkQCd617riLbQX1C68h07jDUG0ziqd4QbV638tAzJpjlbo3oQ2GrgvgyI5xrgObprBgpUKmhfk8YJ0h2HHxXY28DC96QIplnngNfZP3RpFN+mMlaikJ8i5RaKcN1IWrb09mQW28tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOBMAoay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOBMAoay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783485458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEc1lZ0nB4a1x1y5BVVpMLZISPgR4IzaNZqjQkqTrp4=;
	b=ZOBMAoayNAjCHI7+w1ieLO7tDAmF3LrOSvFvz5ntNyk79D48b2K3e4axS4J34qvImEjSmA
	SLPROi9DgRDfIRvu2ckdc6SHkoeK962Oji9GekwUoysPXSOEeZgb46UgOfzh7D4kkJGKjs
	Orex1c+TqGfYxeZejlB3thiwZwTu2ls=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-pnTR7nsDPQGQtoCOdoJiVg-1; Wed,
 08 Jul 2026 00:37:34 -0400
X-MC-Unique: pnTR7nsDPQGQtoCOdoJiVg-1
X-Mimecast-MFC-AGG-ID: pnTR7nsDPQGQtoCOdoJiVg_1783485453
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9AE4180136A;
	Wed,  8 Jul 2026 04:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29D4D18005B5;
	Wed,  8 Jul 2026 04:37:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B623921E6920; Wed, 08 Jul 2026 06:37:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com,  kchamart@redhat.com,
  pierrick.bouvier@oss.qualcomm.com,  peter.maydell@linaro.org,
  mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com,
  eblake@redhat.com,  jpb@kernel.org,  lorenzo.pieralisi@linaro.org,
  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [RFC v1 23/25] docs/interop/firmware.json: Add arm-rme firmware
 feature
In-Reply-To: <20260707224306.1202330-24-mathieu.poirier@linaro.org> (Mathieu
	Poirier's message of "Tue, 7 Jul 2026 16:43:04 -0600")
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
	<20260707224306.1202330-24-mathieu.poirier@linaro.org>
Date: Wed, 08 Jul 2026 06:37:29 +0200
Message-ID: <87fr1um706.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Some distributions provide packages continaing firmware to be run under
> QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
> contain descriptors in /usr/share/qemu/firmware/*.json listing the
> firmware features, so that environments like libvirt can figure out
> which firmware they can load.
>
> Define an optional feature for arm64 firmware to indicate that a
> firmware supports running in a Realm. Firmware implementations need
> extra support for running in a Realm, in particular to distinguish
> shared from private guest memory.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  docs/interop/firmware.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 421bee0e5ed4..c68d7f5013f8 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -161,6 +161,9 @@
>  #     options related to this feature are documented in
>  #     "docs/system/i386/amd-memory-encryption.rst".
>  #
> +# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
> +#           Management Extension (RME).
> +#

Please format like this

   # @arm-rme: The firmware supports running in a Realm, under the Arm
   #     Realm Management Extension (RME).

>  # @intel-tdx: The firmware supports running under Intel Trust Domain
>  #     Extensions (TDX).
>  #
> @@ -229,7 +232,7 @@
>  { 'enum' : 'FirmwareFeature',
>    'data' : [ 'acpi-s3', 'acpi-s4',
>               'amd-sev', 'amd-sev-es', 'amd-sev-snp',
> -             'intel-tdx',
> +             'arm-rme', 'intel-tdx',
>               'enrolled-keys', 'requires-smm',
>               'secure-boot', 'host-uefi-vars',
>               'verbose-dynamic', 'verbose-static' ] }

With the formatting tidied up
Acked-by: Markus Armbruster <armbru@redhat.com>

