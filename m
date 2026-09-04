Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF3517BC1
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543230; cv=none; b=KLQEEof+DtlV/EGY9+1MmmxZekFq+Gvotc/Q5j2I6NrEvnAd8YaA6ojtHel3bcQrjsPKgpfwPqAYE3JvKIhu5tqeBmgoiFd7feHB+3pMeew8t6Ru/wgi5AnJo6M5a3y7/52Uzw0r2YVdD0DEHGyUifwpspOOqPq+Ou3DxFm1w8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543230; c=relaxed/simple;
	bh=0ZP+HRnzu9z6DgT/BXO+5YVGLrMTir6BRcJGXtbrHM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUZ9zz16xsMoVoaiT+cUDTW2+igzJgQIT0hybttNBZ/pqjjzhsXiFFIojC9Io+euAI0qD8yVYQyT7ekyFi+miJpjcJ3lKEBZlfxeDttA9oSCkjz+WlGcnuMphEYM1/YlYd3RJqkn09jNDr1SEHDOmcP7ahY1sTz1hGUmePjdKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh9oj8nx; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh9oj8nx"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-45837e52d8aso1015600fac.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788543223; x=1789148023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNzIgR372J08ntlK40uw/Lpu5PtLTk6ngTClcXiLgnM=;
        b=hh9oj8nxbghH/8a0mfMW0nNlyMdmSjE8t8/JcISWp1U+nMlz8lDffPW7mbbd0wzPr1
         1OPCxV+jDzAByX1QS4JFpvyVaVRIMzYfNxlOHgLJp7w4pX1RCpl+7KGHmznccXQ69PNd
         1Rahzjs5qzQRBYrm2swIuUBtOIcJ0z+LgyLJdt2RDzjReAwuw1w2Pc0ACW2fn6390Yve
         3tMtjjkmmSPuO2fTx1oTt6GVTSF3TB4tQdDxlpx21wPTOEKdM4DzYf9ctgib7zJNRmzJ
         RCvd8SafICg34o47MzuPlBtvvNEOGWoL26FPC/hvJmUGLEXn7Z/VVhhhPgIF6mggY4ji
         g+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788543223; x=1789148023;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNzIgR372J08ntlK40uw/Lpu5PtLTk6ngTClcXiLgnM=;
        b=rgom+6tbFVjtJ0gACTfEUg4Uu49P7Fhu+XddM7a8o1xKzOJc9HcL5KBesDpcI63YTJ
         Y9xxNUWvV28QE8kTcIYMgdQO+gRy6fTRmC6DS/J7b68ALeW2prynxVTrYnepxq9P6ri4
         jXUp/JHqWz2hgv59UoacfVI7jCqMOIb5eA2Z9PlGDLquFoN1FvWxt2KEUJaV1Qx/Hdin
         xlLUZXVJs7Jba2FqFb/21XCkdY6upp/R6xuThrVLNLQlcrAXEWL4lYbdVTfcLWrwwsdm
         BkKs/LH1txlVD3ka/D9Yy1lJ6AAdIsduhCVYz/qnfaaWpQWl5vKO7YmA/mnohL9kwiR/
         3ipQ==
X-Gm-Message-State: AFuF++nfDpvS+YQegN4PbZPjWXoHcCyCbObfto5emetUpM7XnADtzO2P
	PW8LrVkM8Fd3Yb5m4h1dgHhxQFyanN2Rjso6VByactriMYYm+CyFpIp+
X-Gm-Gg: AYBFou065ExFDjupV/VVyVdBEz0YFQSziG5a4a5CM4a3SxFT8yg/n5vnQSrqc2+Ou4w
	ukI4k6RDjB4dNpyNclDJfAEnoZ93ThZbe5Zgfeb+HpIn5F004HIU0QioH5qxc7dq60tqCDOlCNY
	wvK8xSdVEhf5VX9CNcpCnU5v5omloxLJdYCZ/MEn+1FGP1PB+aVRo3o1T7jp3OLs9p2MpwFKydz
	r7o7MuwV7050UZhOlPMoH2UHwa59YvSh1v3Q7YpNQho8YSmFVNeybNA3ZEbIkyjBN5s/IWlb3sH
	AQO75zW/qhzqjU9FSPgPYkShaY+SEux7QdCum12kdrXgXFQ3X4tRbfrLhS6qMPeMc7DTDvFenYs
	sZdgbTV/8gcFoGMI/5CYK2OjVA1mXujbubVPfwZDFk/coZ7uVZoJbdeWnrdSiBMznv+j7hj1Oe1
	EKLwc95/n+aMWeZQdUhxWtFegTRGGQngoVtSMYmCnWaJqa8N+41YMxkUJC8emeQZS6PLG5tJt1E
	PcCYkNWIA==
X-Received: by 2002:a05:6820:81c5:b0:6b1:6462:7e4a with SMTP id 006d021491bc7-6b6fc7d69eamr7174889eaf.13.1788543223122;
        Fri, 04 Sep 2026 10:33:43 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dcb85657sm3425792eaf.7.2026.09.04.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:33:42 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:33:39 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] selftests/vsock: test the assign ioctl
 privilege checks
Message-ID: <apsA808VUA8CrbCd@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-6-9995383e9a8b@meta.com>
 <20260903230147.63ACA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903230147.63ACA1F00A3D@smtp.kernel.org>

On Thu, Sep 03, 2026 at 11:01:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The unprivileged user namespace test spuriously fails because the unprivileged user lacks DAC permissions to open `/dev/vsock`.
> --
> 
> commit 4c5b8557bb5663f827061639a80256407bfe6c8c
> Author: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> selftests/vsock: test the assign ioctl privilege checks
> 
> This commit adds two tests to verify that CAP_NET_ADMIN is required to use
> the IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS ioctl, and that an unprivileged user
> namespace alone is insufficient.
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 53591fa07f1a8..efb94d17d9976 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> [ ... ]
> > @@ -1805,6 +1817,51 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
> [ ... ]
> > +test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
> > +	local helper=/tmp/vsock_assign_g2h_netns
> > +	local unpriv_uid=65534
> > +	local unpriv
> > +	local rc
> > +
> > +	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
> > +	unpriv="${unpriv} --clear-groups"
> > +
> > +	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
> > +		log_host "unprivileged user namespaces unavailable, skipping"
> > +		return "${KSFT_SKIP}"
> > +	fi
> > +
> > +	# The home shared with the guest is root-only, so place the helper where
> > +	# an unprivileged user can execute it.
> > +	vm_ssh "init_ns" -- \
> > +		"cp ./vsock_assign_g2h_netns ${helper} && chmod 755 ${helper}"
> > +
> > +	vm_ssh "init_ns" -- "${unpriv} unshare -Urn ${helper}" &>/dev/null
> > +	rc=$?
> > +
> > +	if [[ "${rc}" -ne "${EPERM}" ]]; then
> 
> [Severity: Medium]
> Will this test spuriously fail in minimal environments like virtme-ng?
> 
> The test helper vsock_assign_g2h_netns is executed as an unprivileged user
> (UID 65534). In minimal environments without systemd-udevd to modify default
> device node permissions, devtmpfs creates /dev/vsock with default 0600
> (root:root) permissions since vsock_device in the kernel does not explicitly
> specify a mode.
> 
> When the unprivileged user tries to open /dev/vsock:
> 
> tools/testing/selftests/vsock/vsock_assign_g2h_netns.c:main() {
>     ...
> 	fd = open("/dev/vsock", O_RDONLY);
> 	if (fd < 0) {
> 		fprintf(stderr, "open /dev/vsock: %s\n", strerror(errno));
> 		return -1;
> 	}
>     ...
> }
> 
> It gets EACCES, causing the C helper to return -1 (exit code 255).
> 
> Since the script expects EPERM (exit code 1) from the ioctl failure, does it
> misinterpret the 255 exit code as a test failure?
> 

I don't know about systemd-udevd, but seems like we can generalize this
to non-zero exits just to be cautious.
