Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B44303C86
	for <kvm@vger.kernel.org>; Tue, 27 Jan 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529268; cv=none; b=Yz8nDhQYHLPk+PDO4LvCsILpN06lHclClU2n34/ENEhH1UoQWCeZysiPBnRU2m9qY8amZZpmaKpqm4BkWqXRPrkqoHnis1A2UqUgfxq8M75Rbx7FJv6LaWWJW8bngPOk0aqVLmQVSE29ICmWSDV/1kKN1m08tMFHEe0n+0Utr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529268; c=relaxed/simple;
	bh=r8wB8XKMWrxBsBbabzaQzMrkGOxJy+J0aNdDMl7v2us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMoZaWOHMf3LKDNBnEWj0cYKtDU8Z09VnpK8es4ZAGjY5SF/EA4IXlXx15pL+QND4iky3C9kX6GcgAg2IX6kOEwjq1j2zttyVO+MscQ6cNxabF0bPrlGfeKCylZECcBApZmAVfupq8d9ecmNDpR8GB/8TxmrWia/l8vyZ2JwhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/gjblA+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/gjblA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769529266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rxro/wnNpgWRWsNBmVd/2tsLR8YpotfU/ZcytZE+Lo=;
	b=T/gjblA+HuJwqqV1N4Y2PArwr6kPQb7nYPugEbVxVMy8gni9zqiJETvTN7Uh7XgPqBi4uO
	DbnUp3PzP6i8OPGVCmb3M+erWnx7Ow5/MvGWQoUT9GDy284xmdsjPa6I6Tdr0jqubmunzV
	DBKQZNJ9AdbS4SdnkO80tAU5p2/LrGw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-VElgGfzENkWp5aaehIL90A-1; Tue,
 27 Jan 2026 10:54:23 -0500
X-MC-Unique: VElgGfzENkWp5aaehIL90A-1
X-Mimecast-MFC-AGG-ID: VElgGfzENkWp5aaehIL90A_1769529261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A43D1800447;
	Tue, 27 Jan 2026 15:54:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 921C618002A6;
	Tue, 27 Jan 2026 15:54:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 4B917180009C; Tue, 27 Jan 2026 16:54:18 +0100 (CET)
Date: Tue, 27 Jan 2026 16:54:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Eduardo Habkost <eduardo@habkost.net>, Stefano Garzarella <sgarzare@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
	Igor Mammedov <imammedo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Luigi Leonardi <leonardi@redhat.com>, 
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v5 6/6] igvm: Fill MADT IGVM parameter field
Message-ID: <aXje_WdH0TegZNoe@sirius.home.kraxel.org>
References: <20260127100257.1074104-1-osteffen@redhat.com>
 <20260127100257.1074104-7-osteffen@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127100257.1074104-7-osteffen@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

  Hi,

> +static int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data,
> +                                Error **errp)
> +{

[3358/3616] Linking target qemu-system-s390x
FAILED: [code=1] qemu-system-s390x 
cc -m64 @qemu-system-s390x.rsp
/usr/bin/ld: libsystem.a.p/backends_igvm.c.o: in function `qigvm_directive_madt':
/home/kraxel/projects/qemu/build/default/../../backends/igvm.c:800:(.text+0x1bdc): undefined reference to `acpi_build_madt_standalone'
collect2: error: ld returned 1 exit status

Moving the function to target/i386/igvm.c and adding a stub version to
stubs/igvm.c should fix that.

take care,
  Gerd

