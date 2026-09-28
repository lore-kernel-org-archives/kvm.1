Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E74973AA
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590443; cv=none; b=Mzp51N2YTqsSJZyl1y6sgx0IKjiqRUq61NgmUADj92s3CBL0kFvrhl5ZKR1Jie1YlI/3banBGa6aEmcZ8ipn77VnmQIjnUbyJ/YPqDYCdkchmS68eauMjFXI/J+k6rNim3+Sw/tZ3K4pOfmPkvmwQ8GXXZU7VLxUghsmqzijuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590443; c=relaxed/simple;
	bh=VZp64+mXhjMQ79RW/kguo2bQvLtTDxYhD4w6Hue2Ejg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOJl8PXNQ2wuxE1rQvlSWKihuPyYcnMqA/Ozmyea1NE/goEZLpBwmmh5INepUR/70jZd/VvXHrjVNlJl3kZ4WRH2xAA1kHG4Fl+RgA4M4Qxtc9sY/O4dUyeLm4eWtUZv5n4xm4TrtT+MyEv1o43E5Fd7NWxP4zU1Yew/qfHCqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EX9uSR/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX9uSR/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790590440;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=WfspKtklugh/OYlKtKuxjrPv/b7W5PFR1FRmVmYBQRs=;
	b=EX9uSR/2mpihPkKFA8/uBHiE+aR//AMaWiI1F6WJoOt7hMZVCu3L1j5zj+8Pq1PpAZKBx0
	S8MnftbzMms8FACzrGhLrsQ9GMMWqp2eT7uflpsMT9xWqhy+sKdOIR1BhonoKtKmXio+v8
	fITKALVNw3/rTm4vZfyWGCLJEF9Ay6I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-3q5wHjZTPt24_x-CQkTmEA-1; Mon,
 28 Sep 2026 06:13:57 -0400
X-MC-Unique: 3q5wHjZTPt24_x-CQkTmEA-1
X-Mimecast-MFC-AGG-ID: 3q5wHjZTPt24_x-CQkTmEA_1790590435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D72B1954229;
	Mon, 28 Sep 2026 10:13:55 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 848C01956095;
	Mon, 28 Sep 2026 10:13:51 +0000 (UTC)
Date: Mon, 28 Sep 2026 11:13:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
Message-ID: <aro93NuZBXYGbD33@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926070057.1234-47-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> query-targets lists each linked target, including none, with its
> arch, endianness, and the machines that target accepts.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
>  qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)


> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6aaa2af709a..d8cdea6203e 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -307,6 +307,41 @@
>  ##
>  { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>  
> +##
> +# @TargetMachines:
> +#
> +# One registered system target and the machines that can run on it.
> +#
> +# @arch: the target architecture
> +#
> +# @endianness: the target endianness
> +#
> +# @machines: machine type names, not aliases
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'TargetMachines',
> +  'data': { 'arch': 'SysEmuTarget',
> +            'endianness': 'EndianMode',
> +            'machines': ['str'] } }

We already have  'QemuTargetInfo' struct which is used
with 'query-target', that should also be used with the
new 'query-targets' command.

We need to add the 'endianness' field to QemuTargetInfo.

I don't think that we need to report machines though.
We already have 'query-machines' which gives much broader
information on the machines. "MachineInfo" needs to
gain

   "targets": ["SysEmuTarget"]

to list which target(s) a machine can be used with.


> +
> +##
> +# @query-targets:
> +#
> +# Return each target linked into this QEMU binary and the machines
> +# whose availability check accepts that target.
> +#
> +# Since: 11.2
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-targets" }
> +#     <- { "return": [ { "arch": "aarch64", "endianness": "little",
> +#                        "machines": [ "virt" ] } ] }
> +##
> +{ 'command': 'query-targets',
> +  'returns': ['TargetMachines'] }


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

